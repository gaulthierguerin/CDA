<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php

//  1. Ecrire un script PHP qui affiche tous les nombres impairs entre 0 et 150, par ordre croissant : 1 3 5 7... 

$a = 1;

do {

    echo $a." ";
    $a+=2;

} while ($a != 151);

// 2. Écrire un programme qui écrit 500 fois la phrase Je dois faire des sauvegardes régulières de mes fichiers

$b = 1;

do {
    echo "<br>".$b.". Je dois faire des sauvegardes régulières de mes fichiers";
    $b++;
} while ($b < 501);
?>

 <!-- 3. Ecrire un script qui affiche la table de multiplication totale de {1,...,12} par {1,...,12} dans un tableau HTML -->

<table border="2">
<?php
echo "<tr><td>  </td>";
//la première ligne
for ($i = 0; $i <= 12; $i++) {
    echo "<th>" . $i . "</th>";
}
echo "</tr>";

for ($j = 0; $j <= 12; $j++) {
    echo "<tr><th>" . $j . "</th>"; // rempli la première colonne
    for ($k = 0; $k <= 12; $k++) {
        
        if ($j==$k) {
            echo "<td><strong>" . $j*$k . "</strong></td>"; //la multiplication d'un nombre par lui-même apparaît en gras
        } else {
            echo "<td>" . $j*$k . "</td>"; // rempli le reste du tableau normalement
        }
        
    }
    echo "</tr>\n";
}
?>
</table>

</body>
</html>