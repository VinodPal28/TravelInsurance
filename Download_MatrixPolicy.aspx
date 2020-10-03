<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Download_MatrixPolicy.aspx.cs" Inherits="Download_MatrixPolicy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%-- <style type="text/css">
        * {
            font-family: arial;
        }

        .text-center {
            text-align: center;
        }

        .span-st {
            width: 200px;
            display: block;
            float: left;
        }

        .text-left {
            text-align: right;
            display: block;
            padding-top: 40px;
        }

        .logo {
            padding: 20px 100px 0 0;
        }

            .logo img {
                width: 200px;
            }

        .border-bottom {
            border-bottom: 1px solid black;
        }

        .tblBase p {
            margin: 3px;
            padding: 0px;
        }
    </style>--%>
</head>
<body style="font-family: 'Helvetica Neue', Helvetica,Arial,sans-serif;">
    <form id="form2" runat="server">
        <div>
        <center> <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label></center>


            <table cellpadding="0" cellspacing="0" align="center" width="1000">
                <tr>
                    <td style="height: 80px; border-bottom: 1px #ccc solid; text-align: left; padding-left: 30px;">
                        <img src="images/Logo.png" width="400"></td>
                </tr>
                <tr>
                    <td style="font-size: 33px; font-weight: 600; text-align: center; font-family: Arial; color: #573f85; height: 70px;">Welcome to Travel Secure</td>
                </tr>



                <tr>
                    <td style="font-family: verdana; padding: 0 25px;">
                        <table cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 160px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Passenger name:</td>
                                <td style="width: 400px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="CustName" runat="server"></span></td>

                                <td style="width: 200px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Membership number: </td>
                                <td style="width: 150px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="PolicyNumber" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 160px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Address:</td>
                                <td style="width: 480px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="CustAddress" runat="server"></span></td>

                                <td style="width: 300px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Membership type:</td>
                                <td style="width: 150px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="Membershiptype" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 160px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">City:</td>
                                <td style="width: 400px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="City" runat="server"></span></td>
                                <td style="width: 200px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Start date:</td>
                                <td style="width: 150px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="PolicyStartdate" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 160px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Pincode:</td>
                                <td style="width: 400px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="PINNo" runat="server"></span></td>
                                <td style="width: 200px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">End date:</td>
                                <td style="width: 150px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="PolicyEndDate" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 160px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Mobile:</td>
                                <td style="width: 400px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;"><span id="Mobileno" runat="server"></span></td>
                                <td style="width: 200px; font-size: 17px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Membership fees:</td>
                                <td style="width: 150px; font-size: 17px; height: 22px; font-family: Arial;color: #797878;">INR <span id="TotalPrice" runat="server"></span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="40"></td>
                </tr>
                <tr>
                    <td style="position: relative;">
                        <div style="width: 700px; height: 200px; background: red; float: left;">
                            <img src="images/travel-img.jpg" width="700" height="320">
                        </div>
                        <div style="width: 550px; height: 270px; background: #573f85; float: left; position: absolute; right: 0; top: 25px; color: #fff; font-family: Arial; font-size: 23px;">
                            <p style="padding: 15px 23px; line-height: 35px; font-size: 26px; font-weight: 600;">With Allianz Travel Secure, you’re covered for Travel Medical Assistance, Luggage Protection, Credit Card Fraud Protection. Enjoy your journey and leave your worries to us.</p>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td height="110"></td>
                </tr>
                <tr>
                    <td style="font-size: 30px; font-weight: bold; text-align: center; font-family: Arial; color: #573f85; height: 70px;">Your Travel Assistance Program Includes</td>
                </tr>

                <tr>
                    <td style="width: 100%; height: 150px; background: #ef8622; padding-top: 10px; padding-bottom: 10px;">
                        <table cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 180px; height: 150px; text-align: center; font-family: Arial; border-right: 1px #fff solid">
                                    <p style="padding: 0; margin: 0; line-height: 0;">
                                        <img src="images/Icon-01.png" width="70">
                                    </p>
                                    <p style="padding: 0; color: #fff; font-size: 20px; width: 90px; text-align: center; margin: 0 auto; line-height: 24px;">Travel Medical Assistance</p>
                                </td>
                                <td style="width: 180px; height: 150px; text-align: center; font-family: Arial; border-right: 1px #fff solid">
                                    <p style="padding: 0; margin: 0; line-height: 0;">
                                        <img src="images/Icon-02.png" width="70">
                                    </p>
                                    <p style="padding: 0; color: #fff; font-size: 20px; width: 90px; text-align: center; margin: 0 auto; line-height: 24px;">Domestic Roadside Assistance</p>
                                </td>
                                <td style="width: 180px; height: 150px; text-align: center; font-family: Arial; border-right: 1px #fff solid">
                                    <p style="padding: 0; margin: 0; line-height: 0;">
                                        <img src="images/Icon-03.png" width="70">
                                    </p>
                                    <p style="padding: 0; color: #fff; font-size: 20px; width: 90px; text-align: center; margin: 0 auto; line-height: 24px;">Digital Risk Protection</p>
                                </td>
                                <td style="width: 180px; height: 150px; text-align: center; font-family: Arial; border-right: 1px #fff solid">
                                    <p style="padding: 0; margin: 0; line-height: 0;">
                                        <img src="images/Icon-04.png" width="70">
                                    </p>
                                    <p style="padding: 0; color: #fff; font-size: 20px; width: 90px; text-align: center; margin: 0 auto; line-height: 24px;">Weather Update Service</p>
                                </td>
                                <td style="width: 180px; height: 150px; text-align: center; font-family: Arial; border-right: 1px #fff solid">
                                    <p style="padding: 0; margin: 0; line-height: 0;">
                                        <img src="images/Icon-05.png" width="70">
                                    </p>
                                    <p style="padding: 0; color: #fff; font-size: 20px; width: 90px; text-align: center; margin: 0 auto; line-height: 20px;">Taxi Assistance</p>
                                </td>
                                <td style="width: 180px; height: 150px; text-align: center; font-family: Arial;">
                                    <p style="padding: 0; margin: 0; line-height: 0;">
                                        <img src="images/Icon-06.png" width="70">
                                    </p>
                                    <p style="padding: 0; color: #fff; font-size: 20px; width: 90px; text-align: center; margin: 0 auto; line-height: 24px;">Luggage Tracking Service</p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td style="font-size: 18px; font-weight: 600; text-align: center; font-family: Arial; color: #000; height: 70px; padding: 15px 130px;">As a privileged Travel Secure member, you also avail a travel insurance underwritten by Bajaj Allianz General Insurance Co.
         Ltd. as Complimentary<br>
                        <span style="font-size: 11px; color: #000;">(The details of your travel insurance are mentioned overleaf) </span>
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 15px; font-family: Arial; color: #000; padding: 0 35px;">You're now protected with Travel Secure powered by Allianz Travel. We are the global leaders in assistance services with operations
        in more than 34 countries. We provide assistance services in the space of - Travel Medical Assistance, Roadside Assistance and 
        Healthcare Assistance.
                    </td>
                </tr>


                <tr>
                    <td style="width: 1000px; padding-left: 32px; height: 50px; font-size: 15px;">
                        <table cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="color: #000; font-weight: bold; font-family: Arial; width: 300px; border-right: 1px #000 solid;font-size:18px;">CIN - U74900HR2012FTC044848</td>
                                <td style="color: #000; font-weight: bold; font-family: Arial; width: 300px; padding-left: 35px;font-size:18px;">GSTIN - 06AAKCA4429N1ZC</td>
                            </tr>
                        </table>
                    </td>
                </tr>


                <tr>
                    <td style="font-size: 15px; font-family: Arial; color: #000; padding: 0 35px; height: 50px;">For any assistance or claim related queries, please feel free to reach us through the below mentioned medium: 
                    </td>
                </tr>


                <tr>
                    <td style="width: 1000px; height: 25px; font-family: Arial; padding-left: 30px;">
                        <table cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 300px; height: 25px;">
                                    <span style="width: 40px; height: 25px;">
                                        <img src="images/call-ion.png" width="30"></span>
                                    <span style="width: 250px; height: 34px; border-left: 1px #000 solid; float: right; font-size: 14px; padding-left: 10px;">Toll Free number
                                        <br>
                                        <span style="font-size:16px;"><strong>1800 419 8581</strong></span>

                                    </span>
                                </td>
                                <td style="width: 300px; height: 25px;">
                                    <span style="width: 40px; height: 25px;">
                                        <img src="images/call-ion-2.png" width="30"></span>
                                    <span style="width: 250px; height: 34px; border-left: 1px #000 solid; float: right; font-size: 14px; padding-left: 10px;">Give a missed call at
                                        <br>
                                        <span style="font-size:16px;"><strong>0124 - 6174700</strong></span>
                                    </span>
                                </td>
                                <td style="width: 300px; height: 25px;">
                                    <span style="width: 40px; height: 25px;">
                                        <img src="images/massage-icon.png" width="30"></span>
                                    <span style="width: 250px; height: 34px; border-left: 1px #000 solid; float: right; font-size: 14px; padding-left: 10px;">Email
                                        <br>
                                        <span style="font-size:16px;"><strong>travel.secure@allianz.com</strong></span>
                                   </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td style="font-size: 15px; font-family: Arial; color: #000; padding: 0 35px; height: 50px;">We welcome you once again to the Allianz family and wish you a happy and safe travel!
                    </td>
                </tr>

                <tr>
                    <td style="width: 154px; height: 60px; padding-left: 35px; float: left; font-size: 15px;">Yours sincerely
                        <br>
                        <br>
                        Megha Talwar
                        <br>
                        Chief Operating Officer
                    </td>
                    <td style="width: 124px; height: 60px; float: left;">
                        <img src="images/Signature.png"></td>
                </tr>

                <tr>
                    <td height="60"></td>
                </tr>


                <br>
                <br>
                <br>

               <%-- <tr>
                    <td style="font-size: 12px; font-family: Arial; color: #000; padding: 0 35px; text-align: center; height: 25px;">AWP Services (India) Pvt. Ltd. | 1st Floor, DLF Square, Jacaranda Marg, DLF Phase – 2, Gurgaon, Haryana – 122002 (India)
                    </td>
                </tr>--%>
            </table>
            <%--<table cellpadding="0" cellspacing="0" align="center">
                <tr>
                    <td style="height: 10px; background: #ef8622; width: 800px;"></td>
                </tr>
            </table>--%>
            <br />
            <br />
            <br />
            <br />
            <table cellspacing="0" cellpadding="0" align="center" width="950">
                <tr>
                    <td height="80"></td>
                </tr>
                <tr>
                    <td style="height: 80px; border-bottom: 1px #ccc solid; text-align: left; padding-left: 30px;">
                        <img src="images/Logo.png" width="400"></td>
                </tr>

                <tr>
                    <td style="font-size: 28px; font-weight: bold; font-family: Arial; color: #573f85; height: 70px; padding-left: 20px;">Your Insurance Details Under This Plan Are</td>
                </tr>

                <tr>
                    <td style="font-family: verdana; padding: 0 25px;>                                                                                                                                                                    px; height: 50px;">
                        <table cellspacing="0" cellpadding="0">
                            <tr>
                                <td style="width: 180px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Membership Number:</td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="MembershipNumber" runat="server"></span></td>
                                <td style="width: 180px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Proposer Name: </td>
                                <td style="width: 300px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="ProposerName" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 182px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Plan Chosen:</td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="InsurancePlan" runat="server"></span></td>
                                <td style="width: 130px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Date Of Birth: </td>
                                <td style="width: 300px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="DOB" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 200px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Geographical Coverage: </td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="GeoName" runat="server"></span></td>
                                <td style="width: 130px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Address: </td>
                                <td style="width: 300px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="Addres" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 182px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Policy Issuance Date:</td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="PolicyIssueDate" runat="server"></span></td>
                                <td style="width: 130px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">City:</td>
                                <td style="width: 300px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="Citys" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 182px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Policy Start Date:</td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="PolicyStartdate2" runat="server"></span></td>
                                <td style="width: 130px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Pincode:</td>
                                <td style="width: 300px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="PIN_Number" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 182px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Policy End Date*:</td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="PolicyEndDate2" runat="server"></span></td>
                                <td style="width: 130px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Passport No:</td>
                                <td style="width: 150px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="PassportNo" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 182px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;"></td>
                                <td style="width: 400px; font-size: 14px; height: 22px; font-family: Arial;"></td>
                                <td style="width: 130px; font-size: 15px; height: 22px; font-family: Arial; font-weight: bold;color: #5d5c5c;">Nominee name:</td>
                                <td style="width: 300px; font-size: 14px; height: 22px; font-family: Arial;color: #797878;"><span id="NomineeName" runat="server"></span></td>
                            </tr>
                            <tr>
                                <td height="20"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" align="center">
                            <tr>
                                <td style="height: 3px; background: #3c3c3b; width: 900px;"></td>
                            </tr>
                            <tr>
                                <td height="20"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

            </table>

            <table cellpadding="0" cellspacing="0" width="900" align="center" style="font-size: 14px;">
                <tr>
                    <th style="width: 350px; font-size: 15px; color: #fff; text-align: left; background: #573f85; height: 40px; padding-left: 30px;">Benefits Limits</th>
                    <th style="width: 300px; font-size: 15px; color: #fff; text-align: left; background: #573f85; height: 40px;">(Max for entire policy period)</th>
                    <th style="width: 200px; font-size: 15px; color: #fff; text-align: left; background: #573f85; height: 40px;">Deductible</th>
                </tr>
                <tr>
                    <td runat="server" id="BenefitsDetails"></td>
                </tr>


            </table>
            <table cellspacing="0" cellpadding="0" align="center">
                <tr>
                    <td style="height: 2px; background: #000; width: 900px;"></td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" align="center">

                <tr>
                    <td height="10"></td>
                </tr>
                <tr>
                    <td style="width: 900px; padding-left: 22px; height: 50px; font-size: 15px; font-weight: bold;">The insurance policy is Complimentary underwritten by Bajaj Allianz General Insurance Co. Ltd. 
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 12px; font-family: Arial; color: #000; padding: 0 16px; height: 35px;">A Company incorporated under Indian Companies Act, 1956 and licensed by Insurance Regulatory and Development Authority of India [IRDA of I] vide Reg No. 113.
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 12px; font-family: Arial; color: #000; padding: 0 16px; height: 35px;">UIN Number: BAJTGOP18091V011718
                    </td>
                </tr>
                <tr>
                    <td style="font-size: 12px; font-family: Arial; color: #000; padding: 0 16px; height: 75px; line-height: 22px;">Terms and conditions applicable as per the T&C document emailed to you<br>
                        *Policy Period:<span id="startdtts" runat="server"></span> to <span id="Enddtts" runat="server"></span>or Date of return of insured whichever is earlier 
                    </td>
                </tr>


              <%--  <tr>

                    <td style="font-size: 12px; font-family: Arial; color: #000; padding: 0 35px; text-align: center; height: 25px;">AWP Services (India) Pvt. Ltd. | 1st Floor, DLF Square, Jacaranda Marg, DLF Phase – 2, Gurgaon, Haryana – 122002 (India)
                    </td>
                </tr>--%>
            </table>
           <%-- <table cellpadding="0" cellspacing="0" align="center">
                <tr>
                    <td style="height: 10px; background: #ef8622; width: 800px; margin: 0 auto"></td>
                </tr>
            </table>--%>


            <br />
            <br />
            <br />
            <br />
            <%--  <br />
            <br />
            <br />
            <br />
           <br />
            <br />
            <br />
             <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
           <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />--%>
            <table cellspacing="0" cellpadding="0" align="center" width="950">
                <tr>
                    <td height="80"></td>
                </tr>
                <tr>
                    <td style="height: 80px; border-bottom: 1px #ccc solid; text-align: left; padding-left: 30px;">
                        <img src="images/Logo.png" width="400"></td>
                </tr>

                <tr>
                    <td style="font-size: 18px; font-weight: 600; font-family: Arial; color: #573f85; height: 70px; padding-left: 20px;">In case of any assistance or claim related query, reach out to us at the below mentioned details
                    </td>
                </tr>


            </table>

            <table cellspacing="0" cellpadding="0" align="center" width="900">
                <tr>
                    <td style="background: #c1ebfb; height: 150px; width: 900px; padding: 10px;">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width: 400px; height: 150px; line-height: 30px; border-right: 1px #000 solid; color: #573f85; font-weight: 18px; font-weight: bold;">
                                    <p style="margin: 0;">24 hour Toll Free Number :</p>
                                    <p style="margin: 0;">Give a Missed Call:</p>
                                    <p style="margin: 0;">Email:</p>
                                    <p style="margin: 0;">Servicing Office:</p>
                                </td>
                                <td style="width: 500px; height: 150px; line-height: 25px; padding-left: 30px; font-weight: 12px; font-weight: bold;">
                                    <p style="margin: 0;">1800 419 8581</p>
                                    <p style="margin: 0;">+91 - 124 - 6174700</p>
                                    <p style="margin: 0;">travel.secure@allianz.com</p>
                                    <p style="margin: 0;">AWP Services (India) Pvt. Ltd., 1st Floor, DLF Square, Jacaranda Marg, Gurgaon, Haryana - 122002 (India)</p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td style="font-weight: 18px; text-transform: uppercase; color: #573f85; font-weight: bold; padding-top: 10px;"><u>IMPORTANT:</u></td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000;">Following is covered as per the Membership Type selected by you:</td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000; height: 40px;"><strong>Global Citizen:</strong> Travel Medical Assistance & Domestic Roadside Assistance</td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000; height: 40px;"><strong>Global Traveler:</strong> Global Citizen + Digital Risk Protection & Weather Update</td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000; height: 40px;"><strong>Global Explorer:</strong> Global Traveler + Taxi Assistance & Luggage Tracking Service</td>
                </tr>

                <tr>
                    <td style="font-weight: 12px; color: #000; height: 110px;">In the event of any assistance or claim requirement always first contact the 24 hours helpline and obtain prior
        notification number from HELPLINE before incurring any expense. For all claims please quote the claims notification
        number and submit claim forms with original medical bills. The coverage provided is subject to details and
        declarations as provided by you at the time of purchasing the Allianz Travel Secure Plan.</td>
                </tr>

                <tr>
                    <td style="font-weight: 18px; text-transform: uppercase; color: #573f85; font-weight: bold; padding-top: 10px;"><u>Declaration by the insured:</u></td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000; height: 50px;">We understand that this policy has been issued based on the information provided by us/our representative and the
        policy is not valid if any of the information provided is incorrect. We also understand that this policy does not cover
        pre-existing illnesses or disability or conditions arising there from as per terms and conditions mentioned in the
        policy wordings.
                    </td>
                </tr>

                <tr>
                    <td style="font-weight: 18px; text-transform: uppercase; color: #573f85; font-weight: bold; padding-top: 10px; height: 50px;"><u>General Exclusions:</u></td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000; height: 300px;">The Company shall be under no liability to make payment hereunder in respect of any Claim directly or indirectly
          caused by, based on, arising out of or howsoever attributable to any of the following: a. The Insured’s participation
          in any naval, military or air force operations whether in the form of military exercises or war games or actual
          engagement with the enemy, whether foreign or domestic. b. War, invasion, acts of foreign enemy, hostilities
          (whether war be declared or not), civil war, civil unrest, rebellion, revolution, insurrection, military or usurped power
          or confiscation or nationalization or requisition of or destruction of or damage to property by or under the order of
          any government or local authority. c. The loss or destruction or damage to any property whatsoever or any loss or
          expenses whatsoever resulting or arising there from or any consequential loss directly or indirectly caused by or
          contributed to by or arising from: d. Ionising radiation or contamination by radioactivity form any nuclear waste
          from combustion of nuclear fuel; or e. The radioactive, toxic, explosive or other hazardous properties of any
          explosive nuclear assembly or nuclear component thereof, or f. Asbestosis or any related Sickness or Disease
          resulting from the existence, production, handling, processing, manufacture, sale, distribution, deposit or use of
          asbestos, or products thereof. g. The Insured’s actual or attempted engagement in any criminal or other unlawful
          act. h. Any consequential losses. i. In respect of travel by the Insured to any country against whom the Republic of
          India has imposed general or special travel restrictions, or against whom it may be impose such restrictions, or any
          country which has imposed or may impose subsequently, such restrictions against travel by a citizen of the Republic
          of India to such country.<br>
                        j. The insured engaging in air travel unless he flies as a passenger
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: 12px; color: #000; height: 80px;">Policy is not valid for visit to Pakistan, Afghanistan, Iran, Iraq, Yemen, Syria, DR Congo, Chad, N Korea, Haj Yatra,
          Kailash Manasarovar yatra and similar terror prone and politically disturbed countries.
                    </td>
                </tr>
               <%-- <tr>
                    <td style="font-size: 12px; font-family: Arial; color: #000; padding: 0 35px; text-align: center; height: 25px;">AWP Services (India) Pvt. Ltd. | 1st Floor, DLF Square, Jacaranda Marg, DLF Phase – 2, Gurgaon, Haryana – 122002 (India)
                    </td>
                </tr>--%>
            </table>


           <%-- <table cellpadding="0" cellspacing="0" align="center">
                <tr>
                    <td style="height: 10px; background: #ef8622; width: 800px; margin: 0 auto"></td>
                </tr>
            </table>--%>



        </div>
    </form>
</body>
</html>
