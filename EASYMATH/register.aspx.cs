using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Configuration;
using System.Reflection.Emit;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Runtime.Remoting.Contexts;
using System.Web.Security;
using System.Net.NetworkInformation;

namespace webAssignment.EASYMATH
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Check if it's the initial page load
            {
                try
                {
                    // Establish database connection
                    using (SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString))
                    {
                        connect.Open();

                        // Fetch the latest username from the database
                        string query = "SELECT TOP 1 username FROM studTable ORDER BY username DESC";
                        SqlCommand cmd = new SqlCommand(query, connect);
                        var lastUsername = cmd.ExecuteScalar() as string;

                        // Extract the numeric part from the last username and increment it
                        int number;
                        if (int.TryParse(lastUsername?.Substring(2), out number))
                        {
                            txtUsername.Text = $"ST{number + 1:000}";
                            txtUsername.ReadOnly = true;
                            txtUsername.Font.Bold = true;
                            connect.Close();
                        }
                        else
                        {
                            // If there are no existing usernames, start with "ST001"
                            txtUsername.Text = "ST001";
                            txtUsername.ReadOnly = true;
                            txtUsername.Font.Bold = true;
                            connect.Close();
                        }
                    }
                }
                catch (Exception ex)
                {
                    UsernameError.Visible = true;
                    UsernameError.ForeColor = System.Drawing.Color.Red;
                    UsernameError.Text = "Error occurred while generating username" + ex.ToString();
                }
            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
             
            try
            {
                var (isValid, gender) = validateInputFields();

                if (!isValid)
                {
                    return;
                }

                SqlConnection connect = new SqlConnection(ConfigurationManager.ConnectionStrings["myConn"].ConnectionString);
                connect.Open();

                string emailQuery = @"
                       SELECT SUM(Count) FROM (
                            SELECT COUNT(*) AS Count FROM studTable WHERE email = @email UNION ALL
                            SELECT COUNT(*) AS Count FROM teachTable WHERE email = @email UNION ALL
                            SELECT COUNT(*) AS Count FROM adminTable WHERE email = @email
                       ) AS EmailCounts";

                string phoneNumberQuery = @"
                       SELECT SUM(Count) FROM (
                            SELECT COUNT(*) AS Count FROM studTable WHERE phoneNumber = @phonenumber UNION ALL
                            SELECT COUNT(*) AS Count FROM teachTable WHERE phoneNumber = @phonenumber UNION ALL
                            SELECT COUNT(*) AS Count FROM adminTable WHERE phoneNumber = @phonenumber
                       ) AS PhoneCounts";

                // Check for duplicates email across of all the stakeholder table
                SqlCommand emailCmd = new SqlCommand(emailQuery, connect); 
                emailCmd.Parameters.AddWithValue("@email", txtEmail.Text);

                // Check for duplicates phone number across of all the stakeholder table
                SqlCommand phoneNumberCmd = new SqlCommand(phoneNumberQuery, connect); 
                phoneNumberCmd.Parameters.AddWithValue("@phonenumber", txtPhoneNumber.Text);

                int emailCheck = Convert.ToInt32(emailCmd.ExecuteScalar());
                int phoneNumberCheck = Convert.ToInt32(phoneNumberCmd.ExecuteScalar());
                int passwordCheck = 0;

                if (emailCheck> 0)
                {
                    EmailError1.Visible = true;
                    EmailError1.ForeColor = System.Drawing.Color.Red;
                    EmailError1.Text = "Email existed!";
                    txtEmail.Text = "";
                }

                if (phoneNumberCheck > 0)
                {
                    PhoneNumberError1.Visible = true;
                    PhoneNumberError1.ForeColor = System.Drawing.Color.Red;
                    PhoneNumberError1.Text = "Phone Number existed!";
                    txtPhoneNumber.Text = "";
                }

                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    PasswordError1.Visible = true;
                    PasswordError1.ForeColor = System.Drawing.Color.Red;
                    PasswordError1.Text = "Password do not matched!";
                    passwordCheck = 1;
                }

                if (emailCheck == 0 && phoneNumberCheck == 0 && passwordCheck == 0) 
                {
                    // Insert into studTable
                    string query = "insert into studTable (userName, fName, lName, gender, dob, email, phoneNumber," +
                                    "religion, city, state, address, country, password) values (@username, @firstName, @lastName," +
                                    "@gender, @dob, @email, @phonenumber, @religion, @city, @state, @country, @address, @password)";
                    SqlCommand cmd1 = new SqlCommand(query, connect);

                    cmd1.Parameters.AddWithValue("@username", txtUsername.Text);
                    cmd1.Parameters.AddWithValue("@firstName", txtFirstName.Text);
                    cmd1.Parameters.AddWithValue("@lastName", txtLastName.Text);
                    cmd1.Parameters.AddWithValue("@gender", gender);
                    cmd1.Parameters.AddWithValue("@dob", txtBirthday.Text);
                    cmd1.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd1.Parameters.AddWithValue("@phonenumber", txtPhoneNumber.Text);
                    cmd1.Parameters.AddWithValue("@religion", txtReligion.Text);
                    cmd1.Parameters.AddWithValue("@city", txtCity.Text);
                    cmd1.Parameters.AddWithValue("@state", txtState.Text);
                    cmd1.Parameters.AddWithValue("@country", txtCountry.Text);
                    cmd1.Parameters.AddWithValue("@address", txtAddress.Text);
                    cmd1.Parameters.AddWithValue("@password", txtPassword.Text);
                    cmd1.ExecuteNonQuery();
                    Response.Redirect("../EASYMATH/login.aspx");
                }
                connect.Close();
            }
            catch (Exception ex)
            {
                RegisterError.Visible = true;
                RegisterError.ForeColor = System.Drawing.Color.Red;
                RegisterError.Text = "Registration Unsuccessful. Please try again!" + ex.ToString();
            }
        }
        private (bool isValid, string gender) validateInputFields()
        {
            bool isValid = true;
            string gender = string.Empty;

            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                isValid = false;
                FirstNameError.Visible = true;
                FirstNameError.ForeColor = System.Drawing.Color.Red;
                FirstNameError.Text = "First name is required!";
            }

            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                isValid = false;
                LastNameError.Visible = true;
                LastNameError.ForeColor = System.Drawing.Color.Red;
                LastNameError.Text = "Last name is required!";
            }

            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                isValid = false;
                LastNameError.Visible = true;
                LastNameError.ForeColor = System.Drawing.Color.Red;
                LastNameError.Text = "Last name is required!";
            }

            if (rbtnMale.Checked)
            {
                gender = "Male";
            }
            else if (rbtnFemale.Checked)
            {
                gender = "Female";
            }
            else
            {
                isValid = false;
                GenderError.Visible = true;
                GenderError.ForeColor = System.Drawing.Color.Red;
                GenderError.Text = "Gender is required!";
            }

            if (string.IsNullOrWhiteSpace(txtBirthday.Text))
            {
                isValid = false;
                BirthdayError.Visible = true;
                BirthdayError.ForeColor = System.Drawing.Color.Red;
                BirthdayError.Text = "Birthday is required!";
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                isValid = false;
                EmailError.Visible = true;
                EmailError.ForeColor = System.Drawing.Color.Red;
                EmailError.Text = "Email is required!";
            }

            if (string.IsNullOrWhiteSpace(txtPhoneNumber.Text))
            {
                isValid = false;
                PhoneNumberError.Visible = true;
                PhoneNumberError.ForeColor = System.Drawing.Color.Red;
                PhoneNumberError.Text = "Phone Number is required!";
            }

            if (string.IsNullOrWhiteSpace(txtReligion.Text))
            {
                isValid = false;
                ReligionError.Visible = true;
                ReligionError.ForeColor = System.Drawing.Color.Red;
                ReligionError.Text = "Religion is required!";
            }

            if (string.IsNullOrWhiteSpace(txtCity.Text))
            {
                isValid = false;
                CityError.Visible = true;
                CityError.ForeColor = System.Drawing.Color.Red;
                CityError.Text = "City is required!";
            }

            if (string.IsNullOrWhiteSpace(txtState.Text))
            {
                isValid = false;
                StateError.Visible = true;
                StateError.ForeColor = System.Drawing.Color.Red;
                StateError.Text = "State is required!";
            }

            if (string.IsNullOrWhiteSpace(txtCountry.Text))
            {
                isValid = false;
                CountryError.Visible = true;
                CountryError.ForeColor = System.Drawing.Color.Red;
                CountryError.Text = "Country is required!";
            }

            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                isValid = false;
                AddressError.Visible = true;
                AddressError.ForeColor = System.Drawing.Color.Red;
                AddressError.Text = "Address is required!";
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                isValid = false;
                PasswordError.Visible = true;
                PasswordError.ForeColor = System.Drawing.Color.Red;
                PasswordError.Text = "Password is required!";
            }

            if (string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                isValid = false;
                ConfirmPasswordError.Visible = true;
                ConfirmPasswordError.ForeColor = System.Drawing.Color.Red;
                ConfirmPasswordError.Text = "Confirm Password is required!";
            }

            return (isValid, gender);
        }
        protected void btnReset_Click(object sender, EventArgs e)
        {

        }

    }
}

