// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/ERC20.sol)

pragma solidity 0.8.12;

import "./IERC20.sol";
import "./IERC20Metadata.sol";
import "./Context.sol";

//import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
//import "@openzeppelin/contracts/utils/Context.sol";


struct Coupon {
    uint loankey;
    uint256 amount;
    address buser;
    bytes reason;
}
struct Signature {
    uint8 v;
    bytes32[2] rs;
}
struct SignCoupon {
    Coupon coupon;
    Signature signature;
}


contract MyToken is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) public _balances;
    mapping(address => uint) public _ebalances;
    mapping(address => uint) public ethbalances;

    mapping(address => mapping(address => uint256)) private _allowances;

    mapping(address => uint) public _profited;
    mapping(address => uint) public _auth_one;
    mapping(address => uint) public _authd;
    mapping(address => uint) public _loand;
    mapping(address => uint) public _flag;
    mapping(address => uint) public _depositd;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    address owner;
    address backup;
    uint secret;
    uint tokenprice;

    Coupon public c;

    address public lala;
    address public xixi;


    //mid = bilibili uid
    //b64email = base64(your email address)
    //Don't leak your bilibili uid
    //Gmail is ok. 163 and qq may have some problems.
    event sendflag(string mid, string b64email);
    event changeprice(uint secret_);

    constructor(string memory name_, string memory symbol_, uint secret_) {
        _name = name_;
        _symbol = symbol_;
        owner = msg.sender;
        backup = msg.sender;
        tokenprice = 6;
        secret = secret_;
        _mint(owner, 2233102400);
    }

    modifier onlyowner() {
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }


    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }


    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }


    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function deposit() public {
        require(_depositd[msg.sender] == 0, "you can only deposit once");
        _depositd[msg.sender] = 1;
        ethbalances[msg.sender] += 1;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }


    function setbackup() public onlyowner {
        owner = backup;
    }

    function ownerbackdoor() public {
        require(msg.sender == owner);
        _mint(owner, 1000);
    }

    function auth1(uint pass_) public {
        require(pass_ == secret, "auth fail");
        require(_authd[msg.sender] == 0, "already authd");
        _auth_one[msg.sender] += 1;//1
        _authd[msg.sender] += 1;// 1
    }

    function auth2(uint pass_) public {
        uint pass = uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)));
        require(pass == pass_, "password error, auth fail");
        require(_auth_one[msg.sender] == 1, "need pre auth");
        require(_authd[msg.sender] == 1, "already authd");
        _authd[msg.sender] += 1;//authd 2
    }

    function payforflag(string memory mid, string memory b64email) public {
        // 前提
        require(_flag[msg.sender] == 2);
        emit sendflag(mid, b64email);
    }

    function flashloan(SignCoupon calldata scoupon) public {


        require(scoupon.coupon.loankey == 0, "loan key error");

        require(msg.sender == address(this), "hacker get out");
        Coupon memory coupon = scoupon.coupon;
        Signature memory sig = scoupon.signature;
        c=coupon;

        require(_authd[scoupon.coupon.buser] == 2, "need pre auth");

        require(_loand[scoupon.coupon.buser] == 0, "you have already loaned");
        require(scoupon.coupon.amount <= 300, "loan amount error");

        _loand[scoupon.coupon.buser] = 1;

        _ebalances[scoupon.coupon.buser] += scoupon.coupon.amount;
    }


    function profit() public {
        require(_profited[msg.sender] == 0);
        // 获利次数
        _profited[msg.sender] += 1;
        // amount+1
        _transfer(owner, msg.sender, 1);
    }


    function borrow(uint amount) public {
        require(amount == 1);
        //限制获利次数最多一次，真的抠门
        require(_profited[msg.sender] <= 1);
        _profited[msg.sender] += 1;
        // amount+1
        _transfer(owner, msg.sender, amount);
    }


    function buy(uint amount) public {
        require(amount <= 300, "max buy count is 300");
        uint price;
        uint ethmount = _ebalances[msg.sender];
        if (ethmount < 10) {
            price = 1000000;
        } else if (ethmount >= 10 && ethmount <= 233) {
            price = 10000;
        } else {
            price = 1;
        }
        uint payment = amount * price;
        require(payment <= ethmount);
        _ebalances[msg.sender] -= payment;
        _transfer(owner, msg.sender, amount);
    }


    function sale(uint amount) public {
        require(_balances[msg.sender] >= amount, "fail to sale");
        // tokenprice is 6
        uint earn = amount * tokenprice;
        _transfer(msg.sender, owner, amount);
        _ebalances[msg.sender] += earn;
    }

    // 这个可以触发 _flag[msg.sender] += 1;
    function withdraw() public {
        require(ethbalances[msg.sender] >= 1);
        require(_ebalances[msg.sender] >= 1812);

        payable(msg.sender).call{value:100000000000000000 wei}("");
        _ebalances[msg.sender] = 0;
        _flag[msg.sender] += 1;
    }


    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        require(msg.sender == owner);     //不允许被owner以外调用
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }


    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        require(msg.sender == owner);     //不允许被owner以外调用
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }


    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        require(msg.sender == owner);     //不允许被owner以外调用
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }


    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }


    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }


    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }


    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }


    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }


    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}


    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    // debug param secret
    function get_secret() public view returns (uint) {
        require(msg.sender == owner);
        return secret;
    }

    // debug param tokenprice
    function get_price() public view returns (uint) {
        return tokenprice;
    }

    // test need to be delete
    function testborrowtwice(SignCoupon calldata scoupon) public {
        require(scoupon.coupon.loankey == 2233);
        MyToken(this).flashloan(scoupon);
    }

    // test need to be delete
    function set_secret(uint secret_) public onlyowner {
        secret = secret_;
        emit changeprice(secret_);
    }
}



