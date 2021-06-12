<?php

$servername = "162.214.174.120";
$username = "barbpaul_root_app";
$password = "mkti2@21";
$dbname = "barbpaul_app_ziit";


// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$dados = file_get_contents("php://input");
$data = json_decode($dados);
$email = "$data->email";
$name = "$data->name";
$pass = "$data->pass";




$sql = 'INSERT INTO 00_usuario (00_email, 00_nome, 00_password) VALUES ("'.$email.'","'.$name.'","'.$pass.'" )';

if ($conn->query($sql) === TRUE) {
    echo "Cadastrado com sucesso!";
} else {
    echo "Error ao se cadastrar ";
}

$conn->close();


?>