<?php
    // Turn dbms_output ON or OFF
    function SetServerOutput($c, $p)
    {
        if ($p)
          $s = "BEGIN DBMS_OUTPUT.ENABLE(NULL); END;";
        else
          $s = "BEGIN DBMS_OUTPUT.DISABLE(); END;";
        $s = oci_parse($c, $s);
        $r = oci_execute($s);
        oci_free_statement($s);
        return $r;
    }

    // Returns an array of dbms_output lines, or false.
    function GetDbmsOutput($c)
    {
        $res = false;
        $s = oci_parse($c, "BEGIN DBMS_OUTPUT.GET_LINE(:LN, :ST); END;");
        if (oci_bind_by_name($s, ":LN", $ln, 255) &&
        oci_bind_by_name($s, ":ST", $st)) {
        $res = array();
        while (($succ = oci_execute($s)) && !$st)
          $res[] = $ln;
            if (!$succ)
             $res = false;
            }
        oci_free_statement($s);
        return $res;
    }
?>


<html lang="EN">
<head>
    <title>The Gambler | Fantastic team</title>
    <link rel="stylesheet" href="../style/main.css"/>
    <link rel="stylesheet" href="../style/fantastic.css"/>
    <link href="https://fonts.googleapis.com/css?family=Muli&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Dancing+Script&display=swap" rel="stylesheet">
</head>
<body>

<nav>
    <h1> The Gambler </h1>
    <h2> Football Statistics Provider </h2>
    <ul>
        <li><a href="home.html">Fantastic Team</a></li>
        <li class="active"><a href="players.php">Players</a></li>
        <li><a href="teams.php">Teams</a></li>
        <li><a href="matches.php">Matches</a></li>
        <li><a href="fantastic.php">Fantastic Team</a></li>
    </ul>
</nav>

<main>
    <header>
        <form method="get">
            Search for the player you want to have information: <br>
            <input type="text" name="name"/>
            <input type="submit" value="Submit"/>
        </form>
    </header>
    <section>

        <?php
            include 'credentials.php';
            if (isset($_GET['name']))
            {
                $name = $_GET['name'];
                $c = oci_connect($username, $password, "//localhost/XE");

                // Turn on buffering of output
                SetServerOutput($c, true);

                // Create some output
                $s = oci_parse($c, "declare begin get_players('$name'); end;");
                oci_execute($s);

                // Display the output
                $output = GetDbmsOutput($c);
                echo '<h4> Choose the exact player you want to get information about from the list below:</h4><br>';
                if ($output){
                    foreach ($output as $line){
                        $plusses=str_replace(" ","+",$line);
                        $pos=strpos($line,"||");
                        $id=intval(substr($line,$pos+2));
                        $line=substr($line,0,$pos);
                        echo '<p><a href="player.php?id='.$id.'">'.$line.'</a></p>';
                    }
                }
            }
        ?>

    </section>
</main>

</body>
</html>