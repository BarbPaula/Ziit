<?php

include "banco.php";

$email = $_POST["email"];
$pass = $_POST["mobile"];

// Insere Usuário
$query = "select `f02_loginUsuario`('".$email."', '".$pass."') as login;";

$teste= conecta();

$busca = mysqli_query($teste, $query);

if(mysqli_num_rows($busca)=="1"){

          
    foreach ($busca as $u):

        $resposta = $u['login'];
            
    endforeach;

    echo json_encode($resposta);
};


?>