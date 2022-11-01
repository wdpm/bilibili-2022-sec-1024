package server

import (
	//  import "crack5/utils/try" => GOPATH/src/crack5/utils/try
	"crack5/utils/try"
	"fmt"
	"github.com/gin-gonic/gin"
	"io"
	"net"
	"net/http"
	"net/url"
	"os"
	"strings"
)

/*func Test(buf []byte, userdata interface{}) bool {
	println("DEBUG: size=>", len(buf))
	println("DEBUG: content=>", string(buf))
	return true
}*/

func SecCheck(myurl string) bool {
	if strings.Contains(myurl, "@") || strings.Contains(myurl, "./") {
		return false
	} else {
		return true
	}
}

func IsInternalIp(host string) bool {
	ipaddr, err := net.ResolveIPAddr("ip", host)

	if err != nil {
		fmt.Println(err)
	}

	fmt.Println(ipaddr.IP, ipaddr.Zone)

	if ipaddr.IP.IsLoopback() {
		return true
	}

	ip4 := ipaddr.IP.To4()
	if ip4 == nil {
		return false
	}
	return ip4[0] == 10 ||
		(ip4[0] == 172 && ip4[1] >= 16 && ip4[1] <= 31) ||
		(ip4[0] == 169 && ip4[1] == 254) ||
		(ip4[0] == 192 && ip4[1] == 168)
}

// 解决跨域问题
func Cors() gin.HandlerFunc {
	return func(c *gin.Context) {
		method := c.Request.Method

		c.Header("Access-Control-Allow-Origin", "*")
		c.Header("Access-Control-Allow-Headers", "Content-Type,AccessToken,X-CSRF-Token, Authorization, Token")
		c.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
		c.Header("Access-Control-Expose-Headers", "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers, Content-Type")
		c.Header("Access-Control-Allow-Credentials", "true")
		if method == "OPTIONS" {
			c.AbortWithStatus(http.StatusNoContent)
		}
		c.Next()
	}
}

// GetData
func GetData(c *gin.Context) {

	try.Try(func() {
		target, status := c.GetQuery("t")

		if !status {
			c.JSON(http.StatusOK, gin.H{
				"msg": "query invalid",
			})
			return
		}
		if len(target) >= 128 || !SecCheck(target) {
			c.JSON(http.StatusBadRequest, gin.H{
				"msg": "illage url",
			})
			return
		}

		u, err := url.Parse(target)

		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"msg": "illage url",
			})
			return
		} else {
			if (u.Scheme != "http" && u.Scheme != "https") || IsInternalIp(u.Hostname()) {
				c.JSON(http.StatusBadRequest, gin.H{
					"msg": "illage url",
				})
				return
			}

			easy := curl.EasyInit()
			defer easy.Cleanup()
			easy.Setopt(curl.OPT_URL, target)
			easy.Setopt(curl.OPT_TIMEOUT, 3)
			easy.Setopt(curl.OPT_FOLLOWLOCATION, false)
			easy.Setopt(curl.OPT_WRITEFUNCTION, func(buf []byte, extra interface{}) bool {
				c.Data(http.StatusOK, "text/html", buf)
				return true
			})
			err := easy.Perform()
			if err != nil {
				fmt.Printf("ERROR: %v\n", err)
				return
			} else {
				c.JSON(http.StatusInternalServerError, nil)
				return
			}
		}
	}).Catch(func() {
		c.JSON(http.StatusBadGateway, nil)
		return
	})

}

func Info(c *gin.Context) {
	c.JSON(http.StatusOK, gin.H{
		"msg": "/etc/server.go",
	})
	return
}

func LoadUrl(r *gin.Engine) {
	r.Use(Cors())
	r.GET("/get", GetData)
	r.GET("/index", Info)
}

func RunAdmin() http.Handler {
	gin.DisableConsoleColor()

	f, _ := os.Create("./logs/server.log")
	gin.DefaultWriter = io.MultiWriter(f)

	r := gin.Default()

	r.Use(gin.LoggerWithFormatter(func(param gin.LogFormatterParams) string {
		return fmt.Sprintf("[Crack5-Web] %s - [%s] \"%s %s %s %d %s \"%s\" %s\"\n",
			param.ClientIP,
			param.TimeStamp.Format("2006-01-02 15:04:05"),
			param.Method,
			param.Path,
			param.Request.Proto,
			param.StatusCode,
			param.Latency,
			param.Request.UserAgent(),
			param.ErrorMessage,
		)
	}))
	r.Use(gin.Recovery())

	LoadUrl(r)

	return r
}