<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<!-- 1. Mois de l'année non bissextile
Créez un tableau associant à chaque mois de l’année le nombre de jours du mois.

Utilisez le nom des mois comme clés de votre tableau associatif.

Affichez votre tableau (dans un tableau HTML) pour faire apparaitre sur chaque ligne le nom du mois et le nombre de jours du mois.

Triez ensuite votre tableau en utilisant comme critère le nombre de jours, puis affichez le résultat. -->
<h1>Exercice 1</h1>

<p>a. Tableau des mois avec leur nombre de jours associés</p>
   <?php

$month = array ("Janvier" => 31, "Février" => 28, "Mars" => 31, "Avril" => 30, "Mai" => 31, "Juin" => 30, "Juillet" => 31, "Août" => 31, "Septembre" => 30, "Octobre" => 31, "Novembre" => 30, "Décembre" => 31);

echo "<table border = 1>";

foreach ($month as $mois => $jours) {

   echo "<tr><td><strong>" .$mois. "</strong><td>" . $jours . "</td></td>";

};

echo "</table>";
?>

<p>b. Tableau des mois avec leur nombre de jours associés trié par nombre de jours décroissant</p>
<?php

arsort($month);
echo "<table border = 1>";

foreach ($month as $mois => $jours) {

    echo "<tr><td><strong>" .$mois. "</strong><td>" . $jours . "</td></td>";
 
 };
 echo "</table>";

?> 

<!-- 2. Capitales -->

<?php
$capitales = array(
    "Bucarest" => "Roumanie",
    "Bruxelles" => "Belgique",
    "Oslo" => "Norvège",
    "Ottawa" => "Canada",
    "Paris" => "France",
    "Port-au-Prince" => "Haïti",
    "Port-d'Espagne" => "Trinité-et-Tobago",
    "Prague" => "République tchèque",
    "Rabat" => "Maroc",
    "Riga" => "Lettonie",
    "Rome" => "Italie",
    "San José" => "Costa Rica",
    "Santiago" => "Chili",
    "Sofia" => "Bulgarie",
    "Alger" => "Algérie",
    "Amsterdam" => "Pays-Bas",
    "Andorre-la-Vieille" => "Andorre",
    "Asuncion" => "Paraguay",
    "Athènes" => "Grèce",
    "Bagdad" => "Irak",
    "Bamako" => "Mali",
    "Berlin" => "Allemagne",
    "Bogota" => "Colombie",
    "Brasilia" => "Brésil",
    "Bratislava" => "Slovaquie",
    "Varsovie" => "Pologne",
    "Budapest" => "Hongrie",
    "Le Caire" => "Egypte",
    "Canberra" => "Australie",
    "Caracas" => "Venezuela",
    "Jakarta" => "Indonésie",
    "Kiev" => "Ukraine",
    "Kigali" => "Rwanda",
    "Kingston" => "Jamaïque",
    "Lima" => "Pérou",
    "Londres" => "Royaume-Uni",
    "Madrid" => "Espagne",
    "Malé" => "Maldives",
    "Mexico" => "Mexique",
    "Minsk" => "Biélorussie",
    "Moscou" => "Russie",
    "Nairobi" => "Kenya",
    "New Delhi" => "Inde",
    "Stockholm" => "Suède",
    "Téhéran" => "Iran",
    "Tokyo" => "Japon",
    "Tunis" => "Tunisie",
    "Copenhague" => "Danemark",
    "Dakar" => "Sénégal",
    "Damas" => "Syrie",
    "Dublin" => "Irlande",
    "Erevan" => "Arménie",
    "La Havane" => "Cuba",
    "Helsinki" => "Finlande",
    "Islamabad" => "Pakistan",
    "Vienne" => "Autriche",
    "Vilnius" => "Lituanie",
    "Zagreb" => "Croatie"
);
?>

<!-- A partir du tableau ci-dessus:

1. Affichez la liste des capitales (par ordre alphabétique) suivie du nom du pays.

2. Affichez la liste des pays (par ordre alphabétique) suivie du nom de la capitale.

3. Affichez le nombre de pays dans le tableau.

4. Supprimer du tableau toutes les capitales ne commençant par la lettre 'B', puis affichez le contenu du tableau. -->

<h1>Exercice 2</h1>

<h3>a. Liste des capitales associées à leur pays, triées par ordre alphabétique</h3>

<table border = 1>
<?php
ksort($capitales);

foreach ($capitales as $capital => $country) {
    echo "<tr><td><strong>" .$capital. "</strong><td>" . $country . "</td></td>";
};
?>
</table>

<h3>b. Liste des pays associées à leur capitales, triés par ordre alphabétique</h3>

<table border = 1>

<?php
asort($capitales); 

foreach ($capitales as $capital => $country) {
    echo "<tr><td><strong>" .$country. "</strong><td>" .$capital."</td></td>";
};

?>

</table>

<h3>c. Affichez le nombre de pays dans le tableau.</h3>

<?php

    $nbpays = count($capitales);

    echo "<p>Le tableau contient ".$nbpays." pays.</p>";
?>

<h3>d. Supprimer du tableau toutes les capitales ne commençant par la lettre 'B', puis affichez le contenu du tableau.</h3>
<table border = 1>
<?php
ksort($capitales);

$i = 0;

while ($i <= count($capitales)) {
    if ($capitales[$i][0] != "B") {
        unset ($capitales[$i]);
    };
    $i++;
};

// foreach ($capitales as $capital => $country) {
//     echo "<tr><td><strong>" .$capital. "</strong><td>" . $country . "</td></td>";
// };

?>
</table>
</body>
</html>
