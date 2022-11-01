<?php
header("content-type:text/html;charset=utf-8");

date_default_timezone_set('PRC');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $filename = $_FILES['file']['name'];
    $temp_name = $_FILES['file']['tmp_name'];
    $size = $_FILES['file']['size'];
    $error = $_FILES['file']['error'];
    if ($size > 2 * 1024 * 1024) {
        echo "<script>alert('文件过大');window.history.go(-1);</script>";
        exit();
    }

    $arr = pathinfo($filename);
    $ext_suffix = $arr['extension'];
    $allow_suffix = array('jpg', 'gif', 'jpeg', 'png');
    if (!in_array($ext_suffix, $allow_suffix)) {
        echo "<script>alert('只能是jpg,gif,jpeg,png');window.history.go(-1);</script>";
        exit();
    }

    $new_filename = date('YmdHis', time()) . rand(100, 1000) . '.' . $ext_suffix;
    move_uploaded_file($temp_name, 'upload/' . $new_filename);
    echo "success save in: " . 'upload/' . $new_filename;

} else if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['c'])) {
        include("5d47c5d8a6299792.php");
        $fpath = $_GET['c'];
        if (file_exists($fpath)) {
            echo "file exists";
        } else {
            echo "file not exists";
        }
    } else {
        highlight_file(__FILE__);
    }
}
?>
