<?php

include "banco.php";

$email = $_POST["email"];


// Insere Usuário
$query = "select * from `00_usuario` where `00_email` like '".$email."'";

$teste= conecta();

$busca = mysqli_query($teste, $query);

if(mysqli_num_rows($busca)=="1"){

    foreach ($busca as $u):

        $resposta[] = $u;
            
    endforeach;


    echo json_encode($resposta);
} else{

    echo $query;
};

 

?>