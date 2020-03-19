using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Web;
using System.Web.Services;
//using System.Xml.;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

public class clinic : System.Web.Services.WebService
{

    public List<DelphiReport> delphiReps = new List<DelphiReport>();
    public List<Departmetn> Departments = new List<Departmetn>();

    public int happ;

    public clinic () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }



    [WebMethod]
    public string ActiveDepartment() {
        return "5";
    }



    [WebMethod]
    public string FullDepartments()
    {
        return "4";
    }



    [WebMethod]
    public List<DelphiReport> GetAppointment(int bakhsh)
    {
        DelphiReport dr = new DelphiReport();
        DelphiReport dr2 = new DelphiReport();

        GetAppFake(bakhsh, dr, dr2);


        //GetAppReal(bakhsh, dr, dr2);



        delphiReps.Add(dr);
        return delphiReps;
    }

    private void GetAppReal(int bakhsh, DelphiReport dr, DelphiReport dr2)
    {
        ifNewDayInitializeFromsettingAppTables();
    }

    private void ifNewDayInitializeFromsettingAppTables()
    {
        SqlConnection con;
        SqlCommand cmd1;
        con = new SqlConnection(Class_ConectionString.GetConnectionString);
        DataSet ds1 = new DataSet();
        ds1.Clear();
        DateTime t = DateTime.Now.Date;
        string sql1 = "select * from Appointment where TimeTurn =" + "'" + t + "'";
        con.Open();
        SqlDataAdapter da1 = new SqlDataAdapter(sql1, con);
        ds1 = new DataSet();
        da1.Fill(ds1);

        DataTable Appointmentdt = ds1.Tables[0];

        //از جدول"setting" 
        //تاریخ ثبت شده را بررسی میکنیم و در صورتیکه تاریخ امروز نبود جدول نوبت دهی را با نوبت های امروز آپدیت میکنیم
        SqlConnection con2;
        SqlCommand cmd2;
        con2 = new SqlConnection(Class_ConectionString.GetConnectionString);
        DataSet ds2 = new DataSet();
        ds2.Clear();
        string sql2 = "select * from setting ";
        con2.Open();
        SqlDataAdapter da2 = new SqlDataAdapter(sql2, con2);
        ds2 = new DataSet();
        da2.Fill(ds2);

        DataTable Settingdt = ds2.Tables[0];
        DateTime data1=DateTime.Now ;//= Settingdt.Rows.OfType<DataRow>().Where(row => (int)row["ID"] == 1).Select(row => (DateTime)row["StartDay"]).First();
        string time = GetDateFromDateTime(data1);
        string timeNow = GetDateFromDateTime(DateTime.Now);
        DateTime tg = Convert.ToDateTime(time);
        DateTime fg = Convert.ToDateTime(timeNow);
        int result = DateTime.Compare(tg, fg);
        if (result == -1)
        {
            //تاریخ امروز را در جدول ثبت میکنیم
            con = new SqlConnection(Class_ConectionString.GetConnectionString);
            SqlCommand cmd6;
            string stQuery1 = "update setting set setting.StartDay=@StartDay where ID=1";
            cmd6 = new SqlCommand(stQuery1);

            cmd6.Parameters.Add("@StartDay", SqlDbType.Date).Value = DateTime.Now.ToShortDateString();

            cmd6.Connection = con;
            con.Open();
            cmd6.ExecuteNonQuery();
            con.Close();
            con.Dispose();




            //اطلاعات بخش ها و زمان فعالیت آنها را از جدول دپارتمان گرفته و به واسطه ی این اطلاعات زمان بندی نوبت های امروز را در جدول وارد میکنیم
            SqlConnection con3;
            SqlCommand cmd3;
            con3 = new SqlConnection(Class_ConectionString.GetConnectionString);
            DataSet ds3 = new DataSet();
            ds3.Clear();
            string sql3 = "select * from Departments ";
            con3.Open();
            SqlDataAdapter da3 = new SqlDataAdapter(sql3, con3);
            ds3 = new DataSet();
            da3.Fill(ds3);
            DataTable Departdt = ds3.Tables[0];
            foreach (DataRow DRow in Departdt.Rows)
            {
                int sectionID = Convert.ToInt32(DRow[1].ToString());//شماره بخش
                int starttime = Convert.ToInt32(DRow[2].ToString());
                int stime = starttime;
                int Endtime = Convert.ToInt32(DRow[3].ToString());
                int RequestRateInHour = Convert.ToInt32(DRow[4].ToString());//تعداد نوبت ها در هر ساعت
                int length = (Endtime - starttime) * RequestRateInHour;
                string[] Department = new string[length];
                int minut = 60 / RequestRateInHour;//مدت زمان هر نوبت
                TimeSpan span = new TimeSpan(1, 2, 0, 30, 0);
                TimeSpan span1 = TimeSpan.FromMinutes(minut);
                TimeSpan span2 = TimeSpan.FromHours(stime);
                TimeSpan span3 = span2.Add(span1);// از زمان شروع فعالیت بخش ؛ هربار مدت زمان هر نوبت را به زمان قبلی اضافه کرده تا زمان کل فعالیت بخش را نوبت دهی کنیم
                for (int i = 0; i < Department.Length; i++)
                {
                    //ثبت نوبت های خام(زمان بندی)
                    // Department[i] = span3.ToString();


                    // string v=stime +"/"+ 
                    //Department[i]=
                    con = new SqlConnection(Class_ConectionString.GetConnectionString);
                    SqlCommand cmd5;
                    string strQuery1 = "insert into Appointment (TimeTurn,DepartmentID,NationalCode,PhoneNumber,DateTurn) values (@TimeTurn,@DepartmentID,@NationalCode,@PhoneNumber,@DateTurn)";
                    cmd5 = new SqlCommand(strQuery1);
                    // cmd5.Parameters.Add("@RequestTime", SqlDbType.Time).Value = timeNow;
                    cmd5.Parameters.Add("@TimeTurn", SqlDbType.Time).Value = span3;
                    cmd5.Parameters.Add("@DepartmentID", SqlDbType.Int).Value = sectionID;
                    cmd5.Parameters.Add("@NationalCode", SqlDbType.NVarChar).Value = "";
                    cmd5.Parameters.Add("@PhoneNumber", SqlDbType.NVarChar).Value = "";
                    cmd5.Parameters.Add("@DateTurn", SqlDbType.Date).Value = DateTime.Now.ToShortDateString();

                    cmd5.Connection = con;
                    con.Open();
                    cmd5.ExecuteNonQuery();
                    con.Close();
                    con.Dispose();
                    span3 = span3.Add(span1);


                }

            }



        }
        else
        {




        }
    }

    public static string GetDateFromDateTime(DateTime datevalue)
    {
        return datevalue.ToShortDateString();
    }

    private static void GetAppFake(int bakhsh, DelphiReport dr, DelphiReport dr2)
    {
        dr.id = bakhsh * 10 + bakhsh;
        dr2.id = bakhsh * 10 + bakhsh;
        DateTime dt = DateTime.FromOADate(39456);
        dr2.date = dt.ToString();
        DateTime MyDate = new DateTime(1904, 12, 12, 1, 4, 1);
        double MyDouble = MyDate.ToOADate();
        dr.date = MyDouble.ToString();

        if ((bakhsh % 2) == 1)
        {
            PersianCalendar pc = new PersianCalendar();
            DateTime thisDate = DateTime.Now;
            thisDate.AddDays(1);

            //PC=PersianCalendar.ToDateTime(now.Year,now.Month,now.Day,now.Hour,now.Minute,0,0);
            
            dr.date = pc.GetYear(thisDate)+"/0"+pc.GetMonth(thisDate)+"/"+pc.GetDayOfMonth(thisDate);
            //(if) ? then : else
            int happ = thisDate.Minute<10 ? thisDate.Minute + 10 : 15+(thisDate.Minute%3);
            dr.time = happ.ToString()+":01";
            //dr.date= PC.ToDateTime(
        }
        else
        {
            PersianCalendar pc = new PersianCalendar();
            DateTime thisDate = DateTime.Now;
            thisDate.AddDays(2);

            //PC=PersianCalendar.ToDateTime(now.Year,now.Month,now.Day,now.Hour,now.Minute,0,0);

            dr.date = pc.GetYear(thisDate) + "/0" + pc.GetMonth(thisDate) + "/" + pc.GetDayOfMonth(thisDate);
            //(if) ? then : else
            int happ = thisDate.Minute < 11 ? thisDate.Minute + 11 : 11 + (thisDate.Minute % 4);
            dr.time = happ.ToString() + ":01";
            //dr.time = "18:01";
        }
        //full
        //if (FullDepartments)
        //{
        //    dr.date = "";
        //    dr.time = "";
        //}
    }

    [WebMethod]
    public string SetAppointment(int resid,string kodemelli,string callerid)
    {
        string ok = "";
        //SetAppFake( resid, kodemelli, callerid);


        //ok=SetAppReal(resid,kodemelli,callerid);
         int ok_int=SetAppFake(resid,kodemelli,callerid);
         if (ok_int == -2)
             ok = "0";
         else
             ok = "ok";


        return ok;
    }

    private int SetAppFake(int resid, string kodemelli, string callerid)
    {

        int result   =   InsertPatient("SetAppointment", kodemelli, DateTime.Now.ToString(), "",  (resid % 10).ToString(), kodemelli, callerid, DateTime.Now.ToString());
        return result;
    }

    public int InsertPatient(string procedure, string ID, string RequestTime, string TimeTurn, string DepartmentID, string NationalCode, string PhoneNumber, string DateTurn)
    {
        int result;

        string connectionString = Class_ConectionString.GetConnectionString;

        using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandTimeout = 120;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procedure;
                //cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@RequestTime", RequestTime);
                cmd.Parameters.AddWithValue("@TimeTurn", TimeTurn);
                cmd.Parameters.AddWithValue("@DepartmentID", DepartmentID);
                cmd.Parameters.AddWithValue("@NationalCode", NationalCode);
                cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNumber);
                cmd.Parameters.AddWithValue("@DateTurn", DateTurn);
                
                try
                {
                    con.Open();
                    result = Convert.ToInt16(cmd.ExecuteNonQuery());
                    con.Close();
                }
                catch (Exception Exception)
                {
                    EventLog.WriteEntry("clinic ws", Exception.Message.ToString());
                    result = -2;
                }
            }
    return result;
    }

    private string SetAppReal(int resid, string kodemelli, string callerid)
    {
        //string resid = textBox1.Text;
        
        int ID = resid;
        string NationalCode = kodemelli;
        SqlConnection con3;
        SqlCommand cmd3;
        con3 = new SqlConnection(Class_ConectionString.GetConnectionString);
        DataSet ds3 = new DataSet();
        ds3.Clear();
        string sql3 = "select * from Appointment where ID=" + ID + "";
        con3.Open();
        SqlDataAdapter da3 = new SqlDataAdapter(sql3, con3);
        ds3 = new DataSet();
        da3.Fill(ds3);
        DataTable appointmentdt = ds3.Tables[0];
        int ResidID = 0;
        foreach (DataRow DRow in appointmentdt.Rows)
        {
            string id = DRow[0].ToString();
            ResidID = Convert.ToInt32(id);
            string National_Code = DRow[4].ToString();
            string requestTime = DRow[1].ToString();
            DateTime requestime = Convert.ToDateTime(requestTime);
            DateTime limitTimeRequest = requestime.AddMinutes(3);
            DateTime now = DateTime.Now;
            int ty = DateTime.Compare(now, limitTimeRequest);
            if (ty == 1)
            {

                if (National_Code == "")
                {
                    SqlConnection conn = new SqlConnection(Class_ConectionString.GetConnectionString);
                    SqlCommand cmd7;
                    string Query1 = "update Appointment set Appointment.NationalCode=@NationalCode  where ID=" + ResidID + "";
                    cmd7 = new SqlCommand(Query1);
                    cmd7.Parameters.Add("@NationalCode", SqlDbType.NVarChar).Value = NationalCode;


                    cmd7.Connection = conn;
                    conn.Open();
                    cmd7.ExecuteNonQuery();
                    conn.Close();
                    conn.Dispose();
                    //MessageBox.Show("نوبت درخواست شده با موفقیت رزرو شد.لطفا برای پیگیری های بعدی شماره رسید را نزد خود نگه دارید");


                }
                else
                {
                    //MessageBox.Show("متاسفانه ،نوبت درخواست شده قبلا رزرو شده است");

                }

            }

        }



        return "ok";
    }

}


public class DelphiReport
{
    public int id;
    public string date;
    public string time;
}




public class Departmetn
{
    public int id;
    public string datemax3sec;
}

class Class_ConectionString
{
    
    private readonly static string Connection = @"Data Source=.;Initial Catalog=Clinic;User ID=sa;Password=1234567aA;Integrated Security=True";
    //private readonly static string Connection = @"Data Source=.;Initial Catalog=Clinic;Integrated Security=True;Connect Timeout=15;Encrypt=False;TrustServerCertificate=False";
    public static string GetConnectionString
    {

        get
        {
            return Connection;
        }
    }
}