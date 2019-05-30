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
    <link rel="stylesheet" href="../style/home.css"/>
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
    <?php
        include 'credentials.php';
        if (isset($_GET['id']))
        {
            $id = $_GET['id'];
            $c = oci_connect($username, $password, "//localhost/XE");
            // Turn on buffering of output
            SetServerOutput($c, true);

            // Create some output
            $s = oci_parse($c, "declare begin get_player_info('$id'); end;");
            oci_execute($s);

            // Display the output
            $output = GetDbmsOutput($c);
            if ($output){
                echo "<section><em>$output[0]</em><h3>First name and last name</h3></section>";
                echo "<section><em>$output[1]</em><h3>Position</h3></section>";
                echo "<section><em>$output[2]</em><h3>Current team</h3></section>";
                echo "<section><em>$output[3]</em><h3>Number of goals in the championship</h3></section>";
                echo "<section><em>$output[4]</em><h3>Number of assists in the championship</h3></section>";
                echo "<section><em>$output[5]</em><h3>Number of First 11 appeareances in the championship</h3></section>";
            }
                
        }
    ?>
</main>

</body>
</html>