<?php
//== подключение к БД с созданным пользователем (решил в env не выносить для наглядности) ==
$mysqli = new mysqli("127.0.0.1", "webuser", "mega_pass_777", "some_db");

//== проверка успешно ли подключение ==
if ($mysqli->connect_errno) {
    echo "Нету подключения к БД: " . $mysqli->connect_error;
    exit();
}

//== запрос на получение первых двух строк из таблицы ==
$result = $mysqli->query("SELECT text FROM some_table LIMIT 2");

//== вывод каждой строки, как отдельную HTML строку ==
while ($row = $result->fetch_assoc()) {
    echo $row['text'] . "<br>";
}

//== закрываем соединение с базой данных ==
$mysqli->close();
?>