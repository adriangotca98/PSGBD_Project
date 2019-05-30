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
        <li><a href="home.html">Home</a></li>
        <li>Players</li>
        <li class="active">Teams</li>
        <li>Matches</li>
        <li>Fantastic Team</li>
    </ul>
</nav>

<main>
    <section>
        <?php
            include 'credentials.php';
            $c = oci_connect($username, $password, "//localhost/XE");

            // Turn on buffering of output
            SetServerOutput($c, true);

            // Create some output
            $s = oci_parse($c, "declare begin get_teams_list(); end;");
            oci_execute($s);

            // Display the output
            $output = GetDbmsOutput($c);
            echo '<h4> Choose the team you want to get information about from the list below:</h4><br>';
            if ($output){
                foreach ($output as $team){
                    $plusses=str_replace(" ","+",$team);
                    $pos=strpos($team,"||");
                    $id=intval(substr($team,$pos+2));
                    $team=substr($team,0,$pos);
                    echo '<p><a href="team.php?id='.$id.'">'.$team.'</a></p>';
                }
            }
        ?>
    </section>
</main>

</body>
</html>