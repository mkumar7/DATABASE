// Illustrating ref cursor for a function without a parameter
import java.sql.*;
import oracle.jdbc.*;
import java.math.*;
import java.io.*;
import java.awt.*;
import oracle.jdbc.pool.OracleDataSource;


class SQLPL{

  //question 2
  public void show(int index) throws SQLException
  {
    try
    {
        //Connecting to Oracle server. Need to replace username and
        //password by your username and your password. For security
        //consideration, it's better to read them in from keyboard.
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
        Connection conn = ds.getConnection("user", "passward");

        CallableStatement cs;
        //Prepare to call stored procedure:
        if(index == 0)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_logs(); end;");
        }
        else if(index == 1)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_supplies(); end;");

        }
        else if(index == 2)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_suppliers(); end;");
        }
        else if(index == 3)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_discounts(); end;");
        }
        else if(index == 4)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_purchases(); end;");
        }
        else if(index == 5)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_products(); end;");
        }
        else if(index == 6)
        {
          cs = conn.prepareCall("begin ? := myfunction.show_employees(); end;");
        }
        else
        {
          cs = conn.prepareCall("begin ? := myfunction.show_customers(); end;"); 
        }        

        //register the out parameter (the first parameter)
        
        cs.registerOutParameter(1, OracleTypes.CURSOR);
        // execute and retrieve the result set
        cs.execute();
        ResultSet rs = (ResultSet)cs.getObject(1);

        // print the results
        if(index == 0)
        {
          while (rs.next()) {
            System.out.println(String.format("%-10s", rs.getString(1))  +
                String.format("%-25s", rs.getString(2))  + 
                String.format("%-25s", rs.getString(3))  +
                String.format("%-35s", rs.getString(4)) +
                String.format("%-25s", rs.getString(5)) +
                rs.getString(6));
          }          
        }
        else if (index == 5) {

          while (rs.next()) {
            System.out.println(
              String.format("%-10s", rs.getString(1))  +
                String.format("%-30s", rs.getString(2))  + 
                String.format("%-25s", rs.getString(3))   +
                String.format("%-25s", rs.getString(4)) +
                String.format("%-25s", rs.getString(5))  +
                rs.getString(6)

                );
          } 
          
        }
        else if(index == 4)
        {
          while (rs.next()) {
            System.out.println(
              String.format("%-10s", rs.getString(1)) +
                String.format("%-10s", rs.getString(2)) + String.format("%-10s", rs.getString(3)) +
               String.format("%-10s", rs.getString(4)) + String.format("%-10s", rs.getString(5))  +
               String.format("%-25s", rs.getString(6)) +
                rs.getString(7)
                );
          }          
        }
        else if(index == 3)
        {
          while (rs.next()) {
            System.out.println(
              String.format("%-10s", rs.getString(1)) +
                String.format("%-10s", rs.getString(2))
                );
          }          
        }
        else if(index == 6)
        {
          while (rs.next()) {
            System.out.println(
                String.format("%-10s", rs.getString(1)) +
                String.format("%-20s", rs.getString(2)) + 
                String.format("%-20s", rs.getString(3)) +
                rs.getString(4)
                );
          }          
        }
        else
        {
          while (rs.next()) {
            System.out.println(
              String.format("%-20s", rs.getString(1)) +
                String.format("%-30s", rs.getString(2)) + 
                String.format("%-30s", rs.getString(3)) +
               String.format("%-30s", rs.getString(4))
                + rs.getString(5));
          }          
        }  
        //close the result set, statement, and the connection
        cs.close();
        conn.close();
  }
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }


  //question 3, purchase_saving(pur#), to report the total saving of any purchase for any given pur#
  public void purchase_saving (String args) throws SQLException {
    try
    {

        //Connecting to Oracle server. 
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:acad111");
        Connection conn = ds.getConnection("user", "passward");

        //Prepare to call stored procedure:
        CallableStatement cs = conn.prepareCall("begin ? := myfunction.purchase_saving(?); end;");
        //register the out parameter (the first parameter)
        cs.registerOutParameter(1, OracleTypes.DOUBLE);
        cs.setString(2, args);


        // execute and retrieve the result set
        cs.execute();
        String rs = cs.getString(1);

        // print the results
        if(rs.equals("-1"))
          System.out.println("Invalid pur#.");
        else
          System.out.println(rs);
  

        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   }
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }



   public void monthly_sale_activities (String args) throws SQLException {
    try
    {

        //Connection to Oracle server. Need to replace username and
        //password by your username and your password. For security
        //consideration, it's better to read them in from keyboard.
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("user", "passward");


        //Prepare to call stored procedure:

        CallableStatement cs = conn.prepareCall("begin myfunction.monthly_sale_activities_jdbc(:1,:2,:3); end;");

        //set the in parameter (the first parameter)
        cs.setString(1, args);

        //register the out parameter (the second parameter)
        cs.registerOutParameter(2, OracleTypes.CURSOR);
        
        cs.registerOutParameter(3, OracleTypes.DOUBLE);        
        //execute the stored procedure
        cs.executeQuery();

        //get the out parameter result.
        String status = cs.getString(3);
        if(status.equals("1"))
        {
          System.out.println("Invalid eid or no sale activities for this eid.");          
        }
        else
        {
            // System.out.println("eid" + ",\t" +
            //     "name" + ",\t" + "MON" + ",\t" +
            //     "YEAR" +
            //     ",\t" + "sales_times" + ",\t" +
            //     "sales_qty" + ",\t" + "sales_amount"
            //     );
        }


        ResultSet rs = (ResultSet)cs.getObject(2);

        // print the results
        while (rs.next()) {
            System.out.println(rs.getString(1) + ",\t" +
                rs.getString(2) + ",\t" + rs.getString(3) + ",\t" +
                rs.getString(4) +
                ",\t" + rs.getString(5) + ",\t" +
                rs.getString(6) + ",\t" + rs.getString(7)
                );
        }

        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   }
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }


   public void add_customer (String a1, String a2, String a3) throws SQLException {
    try
    {

        //Connection to Oracle server. Need to replace username and
        //password by your username and your password. For security
        //consideration, it's better to read them in from keyboard.
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("user", "passward");
        //Prepare to call stored procedure:

        CallableStatement cs = conn.prepareCall("begin myfunction.add_customer(:1,:2,:3); end;");

        //set the in parameter (the first parameter)
        cs.setString(1, a1);
        cs.setString(2, a2);
        cs.setString(3, a3);


      
        //execute the stored procedure
        cs.executeQuery();

        //close the result set, statement, and the connection
        cs.close();
        conn.close();
        System.out.println("Add customer sucessfully.");
   }
   catch (SQLException ex) { System.out.println ("\ninvalid cid.\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }



    public void add_purchase (String a1, String a2, String a3, String a4) throws SQLException {
    try
    {

        //Connection to Oracle server. Need to replace username and
        //password by your username and your password. For security
        //consideration, it's better to read them in from keyboard.
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("user", "passward");
        //Prepare to call stored procedure:

        CallableStatement cs = conn.prepareCall("begin myfunction.add_purchase_jdbc(:1,:2,:3,:4,:5); end;");

        //set the in parameter (the first parameter)
        cs.setString(1, a1);
        cs.setString(2, a2);
        cs.setString(3, a3);
        cs.setString(4, a4);

        //register the out parameter (the second parameter)
        cs.registerOutParameter(5, OracleTypes.DOUBLE);

        //execute the stored procedure
        cs.executeQuery();

        //get the out parameter result.
        String status = cs.getString(5);

        if(status.equals("1"))
          System.out.println("Insufficient quantity in stock.");
        else if(status.equals("0"))
          System.out.println("Add purchase sucessfully.");
        else if(status.equals("2"))
          System.out.println("Invalid cid, eid or pid.");
        else
        {
          int firstArg = 0;
          try {
          firstArg = Integer.parseInt(status);
            } catch (NumberFormatException e) {
            System.err.println("Argument" + status + " must be an integer.");
            System.exit(1);
            }
          System.out.println("The current qoh of the product is\n below the required threshold\n and new supply is required.");
          System.out.println("The new value of qoh after supply is: ");
          System.out.println(firstArg%1000);

        }          

        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   }
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }

    public void delete_purchase (String a1) throws SQLException {
    try
    {

        //Connection to Oracle server. Need to replace username and
        //password by your username and your password. For security
        //consideration, it's better to read them in from keyboard.
        OracleDataSource ds = new oracle.jdbc.pool.OracleDataSource();
        ds.setURL("jdbc:oracle:thin:@castor.cc.binghamton.edu:1521:ACAD111");
        Connection conn = ds.getConnection("user", "passward");
        //Prepare to call stored procedure:

        CallableStatement cs = conn.prepareCall("begin myfunction.delete_purchase_jdbc(:1, :2); end;");

        //set the in parameter (the first parameter)
        cs.setString(1, a1);
        cs.registerOutParameter(2, OracleTypes.DOUBLE);


        //execute the stored procedure
        cs.executeQuery();

        String status = cs.getString(2);

        if(status.equals("0"))
          System.out.println("Delete purchase sucessfully.");
        else
           System.out.println("Invalid pur#.");         

        //close the result set, statement, and the connection
        cs.close();
        conn.close();
   }
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }

}


public class myjdbc {

   public static void main (String args []) throws SQLException {
    try
    {

      //function I need to call:
      // 6.public void delete_purchase (String a1);
      // 5.public void add_purchase (String a1, String a2, String a3, String a4);
      // 4.public void add_customer (String a1, String a2, String a3);
      // 3.public void monthly_sale_activities (String args);
      // 2.public void purchase_saving (String args);
      // 1. public void show(int index);
      //format: args[0]: function id; args[1]: par1 ... 

    File file = new File("out.txt");
    FileOutputStream fos = new FileOutputStream(file);
    PrintStream ps = new PrintStream(fos);
    System.setOut(ps);

      SQLPL test = new SQLPL();

      if(args[0].equals("1"))
      {
        int firstArg = 0;
        if (args.length > 0) {
        try {
          firstArg = Integer.parseInt(args[1]);
        } catch (NumberFormatException e) {
          System.err.println("Argument" + args[1] + " must be an integer.");
          System.exit(1);
        }
        }

        test.show(firstArg);

      }
      else if(args[0].equals("2"))
      {
        test.purchase_saving(args[1]);
      }
      else if(args[0].equals("3"))
      {
        test.monthly_sale_activities(args[1]);
      }
      else if(args[0].equals("4"))
      {
        test.add_customer(args[1], args[2],args[3]);
      }
      else if(args[0].equals("5"))
      {
        test.add_purchase(args[1], args[2],args[3],args[4]);
      }
      else if(args[0].equals("6"))
      {
        test.delete_purchase(args[1]);
      }

   }
   catch (SQLException ex) { System.out.println ("\n*** SQLException caught ***\n" + ex.getMessage());}
   catch (Exception e) {System.out.println ("\n*** other Exception caught ***\n");}
  }
}
