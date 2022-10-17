<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
<?php
    include 'conexao.php';
    $consulta;
    $consultaCargo = $cn->query("select * from tbl_empregos group by Cargo");
    $consultaArea = $cn->query("select * from tbl_empregos group by Area");
?>
<nav class="navbar navbar-expand-lg bg-light">
    <h5>Pesquisa</h5>
    <div class="col-sm-2">
        <select id="cat" name="cat" class="form-select">
            <option disabled>Cargo</option>
            <?php while($exibirCargo=$consultaCargo->fetch(PDO::FETCH_ASSOC)){?>
            <option><?php echo $exibirCargo['Cargo']; ?></option>
            <?php } ?>
        </select>
    </div>
    <div class="col-sm-2">
    <select id="cat" name="cat" class="form-select">
            <option disabled>Area</option>
            <?php while($exibirArea=$consultaArea->fetch(PDO::FETCH_ASSOC)){?>
            <option><?php echo $exibirArea['Area']; ?></option>
            <?php } ?>
        </select>
    </div>
    <form class="d-flex" role="search">
        <button class="btn btn-outline-success" type="submit">Search</button>
    </form>
</nav>
<div class="table-responsive">
    <table class="table table-bordered">
        <tr>
            <th>Registro</th>
            <th>Nome</th>
            <th>Cargo</th>
            <th>Area</th>
            <th>Salario</th>
            <th>Status</th>
            <th>Editar</th>
            <th>Excluir</th>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </table>
</div>
</body>
</html>