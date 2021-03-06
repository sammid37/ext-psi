<?php
  include_once '0header.php';
  include_once '0menu.php';
  include_once '0slide.php';

?>
<!-- CONTEÚDO PRINCIPAL -->
<div class="container">
  <div class="row">
  <!-- Relatos -->
    <div class="col s12 m8 l8">
    <?php
    include "conexao.php";
    $con = mysqli_connect($host,$user,$psw,$schema) or die("Conexão ruim");
    $consult = "SELECT * FROM Relatos R, Humor H, Aluno A WHERE R.codhumor = H.numhumor AND R.codAutor = A.matriAlu AND R.privacidade='2' ORDER BY R.cod DESC ";
    // R.humor = H.numhumor
    // R.codAutor = A.matriAlu
    $result = mysqli_query($con,$consult);

    // imprimindo todos os relatos
    while($row=mysqli_fetch_array($result)){
      echo
      "<div class='card'>
        <div class='card-content'>
          <h4>" . $row['titulo'] . " </h4>
          <h6>por <a href='#' class='peach-pink-text'>".$row['nome']." ".$row['sobrenome']."</a>,
          humor <a href='#' class='peach-pink-text'>".$row['humor']."</a></h6>
          <div class='divider'></div>
        </br>
          <p>" . $row['corpo'] . "</p>
        </div>
      </div>";
    }
    ?>
    </div>
    <!-- Exercícios -->
    <div class="col s12 m4 l4">
      <div class="card">
        <div class="card-content yellow lighten-3">
          <p>A opção de favoritar exercício ainda não está disponível.</p>
        </div>
      </div>
      <?php
      include "conexao.php";
      $con = mysqli_connect($host,$user,$psw,$schema) or die("Conexão ruim");
      $consult = "SELECT * FROM Exercicios E, Categoria C WHERE E.categoria=C.categoria ORDER BY cod DESC";
      $result = mysqli_query($con,$consult);
      while($row=mysqli_fetch_array($result)){
        echo
        "
        <div class='card'>
          <div class='card-image'>
            <img src='".$row['imgexer']."'>
            <a class='btn-floating halfway-fab waves-effect waves-light deep-violet' onClick='favv()'>
              <i class='material-icons'>favorite_border</i>
            </a>

          </div>
          <div class='card-content'>
            <h5>".$row['titulo']."</h5>
            <p>".$row['conteudo']."</p>
          </div>
          <div class='card-action'>
            <a href='#'><div class='chip'>" . $row['catnome'] . "</div></a>
          </div>
        </div>
        ";
      }
    ?>
    <!-- <div class="card">
      <div class="card-image">
        <img src="https://data.whicdn.com/images/274909313/large.jpg">
      </div>
      <div class="card-content">
        <h5>Exercício de teste</h5>
        <p>Conteúdo do exercício teste. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
      </div>
      <div class="card-action">
        <a href="#"><div class="chip"humor>Categoria</div></a>
      </div>
    </div> -->
</div>
<?php
  include_once '0footer.php';
?>