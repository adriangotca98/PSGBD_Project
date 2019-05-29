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
    <title>The Gambler | Matches </title>
    <link rel="stylesheet" href="../style/main.css"/>
    <link rel="stylesheet" href="../style/fantastic.css"/>
    <link href="https://fonts.googleapis.com/css?family=Muli&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Dancing+Script&display=swap" rel="stylesheet">
</head>
<body>

<nav>
    <h1> The Gambler</h1>
    <h2> Football Statistics Provider </h2>
    <ul>
        <li><a href="home.html">Home</a></li>
        <li>Players</li>
        <li>Teams</li>
        <li class="active">Matches</li>
        <li>Fantastic Team</li>
    </ul>
</nav>

<main>
    <header>
        <form method="get">
            Select the stage to get the matches
            : <br>
            <input type="number" min="1" max="1023" name="stage"/>
            <input type="submit" value="Submit"/>
        </form>
    </header>
    <section>

        <?php
        if (isset($_GET['stage']))
        {
            $stage = $_GET['stage'];
            $c = oci_connect("gambler", "gambler", "//localhost/XE");

            // Turn on buffering of output
            SetServerOutput($c, true);

            // Create some output
            $s = oci_parse($c, "declare begin dbms_output.put_line(get_matches(".$stage.")); end;");
            oci_execute($s);

            // Display the output
            $output = GetDbmsOutput($c);
            echo "<h3>The Matches of stage ".$stage."</h3>";
            for ($i=0; $i<1024; $i+=2)
                echo "<p><a href='match.php?match=".(($stage-1)*512+($i/2+1))."'>".($i/2+1)." ".$output[$i]." vs ".$output[$i+1]."</a></p>";

        }
        ?>

    </section>
</main>

</body>
</html>