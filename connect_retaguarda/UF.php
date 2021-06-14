<?php

include "banco.php";

$email = $_POST["email"];


// Insere Usuário
$query = "select `00_01_cod` as cod, `00_01_sigla` as sigla from  `00_01_Estados IBGE`";

$teste= conecta();

$busca = mysqli_query($teste, $query);

if(mysqli_num_rows($busca)<>"0"){

          
    foreach ($busca as $u):

        $resposta[] = $u;
            
    endforeach;

    echo json_encode($resposta);

};



?>