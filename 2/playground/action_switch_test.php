<?php

$id = "0";
if ($id !== 0 && $id !== 1) {
    switch ($id) {
        case 0:
            echo "case 0";
            break;
        case 1:
            echo "case 1";
            throw new Exception("id invalid in " . __CLASS__ . __FUNCTION__);
            break;
        default:
            break;
    }
}


