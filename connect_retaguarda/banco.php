<?php
    
    
    function conecta(){

        $bdServ="162.214.174.120";
        $bdUsuario="barbpaul_root_app";
        $bdSenha="mkti2@21";
        $bdBanco="barbpaul_app_ziit";

        $conexao = mysqli_connect($bdServ,$bdUsuario,$bdSenha,$bdBanco);

        if(mysqli_connect_error($conexao)){

            return 0;

        } else{
            return $conexao;
        }
    } 



    
    




?>

