<?php
include "conexao.php";
$con = mysqli_connect($host,$user,$psw,$schema) or die("Conexão ruim");
// recuperando informações
$psi = $_POST['psi'];
$alu = $_POST['alu'];

// estabelecendo conexão com o banco

$insert = "INSERT INTO Atribuicao(matriPsi,matriAlu) VALUES ($psi,$alu)";
$result = mysqli_query($con,$insert);

if($result){
  echo"<h5 style='font-size:14pt' class='light-green-text'>Atribuição sucessida</h5>";
} else{
  echo "<h5 style='display:none'>Falha ao estabelecer atribuição</h5>";
}
// fecha conexão com o banco
mysqli_close($con);
?>
