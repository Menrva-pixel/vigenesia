<?php

try{
$connection = new PDO('mysql:host=localhost,dbname=name','user','password');
$connection ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXECEPTION);
echo "yes Connected";

}catch(PDIExeption $exc){
echo $exc ->getMessage();
die("tidak bisa terhubung");
}

?>