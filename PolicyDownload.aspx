<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PolicyDownload.aspx.cs" Inherits="PolicyDownload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
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
        .tblBase p
        {
            margin:3px;
            padding:0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <center> <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label></center>
    <div>
    <table cellpadding="0" cellspacing="0" align="center">
        <tr>
            <td style="margin: 0 auto; width: 1100px;">
                <div class="text-left logo">
                    <img src="../Assets/images/logo.png" />
                   <%-- <img src="img/logo.png">--%></div>
                <div class="border-bottom">
                    <table style="padding: 20px 0;">
                        <tr>
                            <td style="width: 1170px;">
                                <div class="text-center">
                                    <p style="font-size:14px">Bajaj Allianz General Insurance Company Ltd.</p>
                                    <p style="font-size:12px">Regd. Office - GE Plaza, Airport Road, Yerwada, Pune - 411006 (India)</p>
                                    <p style="font-size:14px"><b>TRAVEL POLICY IDENTIFICATION AND SCHEDULE</b></p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="border-bottom">
                    <table style="width: 1100px; padding: 20px 0;font-size:12px;">
                        <tr>
                            <td><span class="span-st"><b>Policy No.:</b></span><span runat="server" id="PolicyNumber"> ddgfgfgf</span></td>
                            <td><span class="span-st"><b>IMD Code:</b></span><span> 10031022 </span></td>
                        </tr>
                        <tr>
                            <td><span class="span-st"><b>Insurance Plan: </b></span><span runat="server" id="InsurancePlan"></span></td>
                            <td><span class="span-st"><b>Geographical Coverage:</b></span><span runat="server" id="GeoName"> </span></td>
                        </tr>
                        <tr>
                            <td><span class="span-st"><b>Insured Person(s):</b></span><span runat="server" id="title"> </span> <span runat="server" id="CustName"> </span></td>
                            <td><span class="span-st"><b>Passenger: </b></span><span runat="server" id="PassengerType"></span></td>
                        </tr>
                        <tr>
                            <td><span class="span-st"><b>Date of Birth: </b></span><span runat="server" id="DOB"> </span></td>
                            <td><span class="span-st"><b>Nominee Name: </b></span><span runat="server" id="NomineeName"></span></td>
                        </tr>
                        <tr>
                            <td><span class="span-st"><b>Passport No: </b></span><span runat="server" id="PassportNo"> </span></td>
                            <td><span class="span-st"><b>State code: </b></span><span runat="server" id="StateCode"></span></td>
                        </tr>
                        <tr>
                            <td><span class="span-st"><b>Address:</b></span> <span style="display: block; float: left;" runat="server" id="CustAddress"> </span></td>
                            <td><span class="span-st"><b>GSTIN/UIN: </b></span><span runat="server" id="GSTIN"></span></td>
                        </tr>
                    </table>
                </div>
                <div class="border-bottom">
                    <table cellpadding="0" cellspacing="0" style="width: 1000px;font-size:12px;">
                        <colgroup>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <td>
                                    <p><b>BENEFITS</b></p>
                                </td>
                                <td>
                                    <p><b>LIMITS (max for entire policy period)</b></p>
                                </td>
                                <td>
                                    <p><b>DEDUCTIBLE</b></p>
                                </td>
                            </tr>

                            <tr >
                                <td runat="server" id="BenefitsDetails">
                                    <%--<p>Medical Expenses &amp; Evacuation</p>--%>
                                </td>                              
                            </tr>
                        </tbody>
                    </table>
                </div>
             <%--   <div class="border-bottom">
                    <table style="padding: 20px 0;font-size:12px;">
                        <tr>
                            <td>
                                <p>Please note:</p>
                                <p>* Indicates only 50 % of Sum Assured in respect of death of insured person below 18 years of age</p>
                                <p>** per baggage maximum 50% &amp; per item in the baggage maximum 10%</p>
                                <p>*** including delivery charges</p>
                            </td>
                        </tr>
                    </table>
                </div>--%>

                <table class="tblBase" cellpadding="0" cellspacing="0" style="width: 1000px;font-size:12px;padding: 0px 0;">
             
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <tbody>
                        <tr >
                            <td>
                                <p>
                                    <br />
                                </p>

                                <p>Base Premium :</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>

                                <p runat="server" id="BasePrice"></p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>Integrated GST @ 18%:</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p runat="server" id="GstPrice"></p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>Total Premium:</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p runat="server" id="TotalPrice"></p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>Policy Issuance Date:</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td colspan="3">
                                <p runat="server" id="PolicyIssueDate"></p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>Policy Period:</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td colspan="3">
                                <p>From : <span runat="server" id="PolicyStartdate"></span> To : <span runat="server" id="PolicyEndDate"></span></p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>24-Hours Helpline :</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td colspan="2">
                                <p>Telephone No.: +91 124 - 4343838</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>Claims and policy Assistance Email :</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td colspan="2">
                                <p><a href="mailto:travel@allianz.com">travel@allianz.com</a></p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <p>Address of Notification of Claims :</p>
                            </td>
                            <td>
                                <p>
                                    <br />
                                </p>
                            </td>
                            <td colspan="6">
                                <p>1st Floor, DLF Square, M-Block, Jacaranda Marg, Phase-II Gurgaon, Haryana - 1220022</p>
                            </td>
                        </tr>

                    </tbody>
                </table>


                <table class="tblBase" style="width: 1050px; padding: 20px 0;font-size:12px;">
                    <tr>
                        <td>
                            <p>IMPORTANT: Always and COMPULSORILY first contact the 24 hours helpline and seek prior authorization from HELP LINE before incurring any expense. For all claims please quote the claims authorization number and submit claim forms with original medical bills. The coverage provided is subject to details and declaration in the proposal form and attached policy wordings.</p>

                            <p>
                                <br />
                            </p>
                          
                            <p>For &amp; on behalf of Bajaj Allianz General Insurance Co. Ltd.</p>
                         <%--   <img src="http://via.placeholder.com/96x62?text=signature" alt="Signature">--%>
                              <img src="../Signature/singnature.png" />
                            <p>Authorized Signatory</p>

                            <p>
                                <br />
                            </p>

                            <p>DECLARATION BY THE INSURED: We understand that this policy has been issued based on the information provided by us/our representative and the policy is not valid if any of the information provided is incorrect. We also understand that this policy does not cover pre-existing illnesses or disability or conditions arising there from as per terms and conditions mentioned in the policy wordings.</p>

                            <div class="text-left">
                                <p>Signature of Insured</p>
                            </div>

                            <div class="text-center">
                                <p>Regd. Office : GE Plaza, Airport Road, Pune (India)</p>

                                <p>Service Tax Reg. No.: AABCB57530G-ST-001</p>
                            </div>
                        </td>
                    </tr>
                </table>


            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
