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
    <title>The Gambler | Match </title>
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
        <li><a href="home.html">Home</a></li>
        <li>Players</li>
        <li>Teams</li>
        <li class="active">Matches</li>
        <li>Fantastic Team</li>
    </ul>
</nav>

<main>
    <header>
        <form method="get" action="matches.php">
            Select the stage to get the matches
            : <br>
            <input type="number" min="1" max="1023" name="stage"/>
            <input type="submit" value="Submit"/>
        </form>
    </header>
    <section>

        <?php
        include 'credentials.php';
        if (isset($_GET['match']))
        {
            $match = $_GET['match'];

            $c = oci_connect($username, $password, "//localhost/XE");

            // Turn on buffering of output
            SetServerOutput($c, true);

            // Create some output
            $s = oci_parse($c, "declare begin dbms_output.put_line(get_match_info(".$match.")); end;");
            oci_execute($s);

            // Display the output
            $output = GetDbmsOutput($c);
            $name1 = $output[0];
            $name2 = $output[1];
            $date = $output[2];
            $half = $output[3];
            $ful = $output[4];
            $stad = $output[5];
            $att = $output[6];
            $ref = $output[7];
            echo "<h3>".$name1." vs ".$name2."</h3>";

            echo "<br><h4>General Information</h4>";
            echo "<p>Match time: $date</p>";
            echo "<p>Half-time score: $half</p>";
            echo "<p>Final-time score: $ful</p>";
            echo "<p>Stadium name: $stad</p>";
            echo "<p>Attendance: $att</p>";
            echo "<p>Referee: $ref</p>";

            echo "<br><h4>Lineups</h4>";
            echo "<div class='lineups'>";
            echo "<ul>";
            for ($i=8; $i<=18; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "<ul>";
            for ($i=19; $i<=29; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "</div>";

            echo "<br><h4>Substitutions</h4>";
            echo "<div class='lineups'>";
            echo "<ul>";
            for ($i=30; $i<=32; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "<ul>";
            for ($i=33; $i<=35; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "</div>";

            $goal1 = $output[36];
            $goal2 = $output[37];

            echo "<br><h4>Goals</h4>";
            echo "<div class='lineups'>";
            echo "<ul>";
            for ($i=38; $i<=38+$goal1-1; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "<ul>";
            for ($i=38+$goal1; $i<=38+$goal1+$goal2-1; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "</div>";

            $nxt = 38+$goal1+$goal2;
            $nr1 = $output[$nxt];
            $nr2 = $output[$nxt+1];
            echo "<br><h4>Cards</h4>";
            echo "<div class='lineups'>";
            echo "<ul>";
            for ($i=$nxt+2; $i<=$nxt+2+$nr1-1; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "<ul>";
            for ($i=$nxt+2+$nr1; $i<=$nxt+2+$nr1+$nr2-1; $i++)
                echo "<li> $output[$i] </li>";
            echo "</ul>";
            echo "</div>";

        }
        ?>

    </section>
</main>

</body>
</html>