<?php
$startTime = microtime(true);
date_default_timezone_set('Europe/Moscow');

//проверка попадания в область
function check($x, $y, $r) 
{
    return ($x == 0 && $y == 0) || 
            ($x <= 0 && $y <= 0 && $x >= (-1)*$r && $y >= (-1)*($r/2)) || 
            ($x <= 0 && $y >= 0 && ((($r/2 - (-1)*$x >= 1) && $y < $r/2) || (($r/2 - $y >= 1) && $x > (-1)*$r/2))) || 
            (($x * $x + $y * $y) <= $r * $r / 4 && $x >= 0 && $y >= 0);
}


if (isset($_POST['x']) && isset($_POST['y']) && isset($_POST['r'])) {
    
    $x = $_POST['x'];
    $y = $_POST['y'];
    $r = $_POST['r'];

    //валидность
    if (is_numeric($r) && is_numeric($x) && is_numeric($y)) {
        $result = check($x, $y, $r);
        $workScriptTime = round((microtime(true) - $startTime), 10);
        
        $response = ['x' => $x, 'y' => $y, 'r' => $r, 'result' => $result, 'currentTime' => date('H:i:s'), 'workTime' => $workScriptTime];

        header('Content-Type: application/json');
        echo json_encode($response);
    } else {
        echo json_encode(['error' => "ошибка!! введите данные согласно условиям"]);
    }
} else {
    echo json_encode(['error' => "Параметры R, X и Y не были переданы."]);
}
?>
