import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;


class Highscores
{
  
 String user = "sql12236006";
 String pass = "GewbCLRZnV";
 String db = "sql12236006";
 String host = "sql12.freemysqlhosting.net";
 
 MySQL dbConnection;
 
 Highscores(processing.core.PApplet _papplet)
 {
   dbConnection = new MySQL(_papplet, host, db, user, pass);
 }
 
 boolean HighscoreConnect()
 {
   if(dbConnection.connect())
   {
     return true;
   }
   else
   {
     return false;
   }
 }
 
 StringList GetNames()
 {
   int counter = 0;
   StringList Names = new StringList();
   dbConnection.query("SELECT * FROM `Highscores` ORDER BY `Score` DESC");
   while(dbConnection.next() && counter < 10)
   {
     Names.append(dbConnection.getString("Name"));
     counter += 1;
   }
   return Names;
 }
 
 IntList GetScores()
 {
   int counter = 0;
   IntList Scores = new IntList();
   dbConnection.query("SELECT * FROM `Highscores` ORDER BY `Score` DESC");
   while(dbConnection.next() && counter < 10)
   {
     Scores.append(dbConnection.getInt("Score"));
     counter += 1;
   }
   return Scores;
 }
 
 void UpdateHighscores(String newName, int newScore)
 {
   dbConnection.query("INSERT INTO `Highscores`(`Name`, `Score`) VALUES ('%s',%d)", newName, newScore);
 }

}