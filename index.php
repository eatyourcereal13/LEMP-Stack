<?php
$mysqli = new mysqli("127.0.0.1", "webuser", "mega_pass_777", "some_db");
if ($mysqli->connect_errno) {
    echo "Нету подключения к БД: " . $mysqli->connect_error;
    exit();
}

$result = $mysqli->query("SELECT text FROM some_table LIMIT 2");

while ($row = $result->fetch_assoc()) {
    echo $row['text'] . "<br>";
}

$mysqli->close();
?>