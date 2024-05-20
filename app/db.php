<?php

class Database
{
    private $host;
    private $dbname;
    private $user;
    private $pass;

    function __construct()
    {
        $this->host = "db";
        $this->dbname = getenv("MYSQL_DATABASE");
        $this->user = getenv("MYSQL_USER");
        $this->pass = getenv("MYSQL_PASSWORD");
    }

    public function connect()
    {
        $conn_str = "mysql:host=" . $this->host . ";dbname=" . $this->dbname;

        try {
            $conn = new PDO($conn_str, $this->user, $this->pass);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $conn;
        } catch (PDOException $e) {
            echo "Connection Failed: " . $e->getMessage();
        }
    }
}