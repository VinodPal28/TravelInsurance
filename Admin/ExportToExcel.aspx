<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExportToExcel.aspx.cs" Inherits="ExportToExcel" %>


<link href="../assets/combine.min.css" rel="stylesheet" />
<a href="../assets/combine.scss"></a>
<script src="../assets/main.js"></script>
<script src="../assets/jquery.js"></script>
<script src="../assets/main.min.js"></script>
<script src="../assets/moment.min.js"></script>
<script src="../assets/daterangepicker.js"></script>
<script type="text/javascript">
    $("document").ready(function () {
        $('#btnclick').trigger('click');
    });
</script>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Commission</title>
    <style type="text/css">
        body {
            font-family: arial;
        }
    </style>
    <script>setTimeout(function () { window.location.href = "/Admin/CommissionGeneration.aspx" }, 600);</script>

</head>
<body>
    <%--   <form id="form1" runat="server">--%>
    <div id="ck" runat="server" style="width: 70%; border-collapse: collapse; border-color: red"></div>
    <div id="Cont" runat="server" style="width: 70%; border-collapse: collapse; border-color: red">
        <table cellspacing="0" cellpadding="0" align="left" style="width: 50%; border-collapse: collapse; border-color: red">
            <!-- header section start here -->
            <table cellspacing="0" cellpadding="0" align="center" style="width: 65%; border: solid; border-color: #e0e0e0; border-width: 1px;">
                <tr>
                    <td style="height: 50px; font-weight: 600;">Invoice Raised to :</td>
                </tr>
                <tr>
                    <td style="height: 40px;">AWP Assistance (India) Pvt Ltd</td>
                    <td style="height: 40px;"></td>
                    <td style="height: 40px;">Date: <span runat="server" id="date"></span></td>
                    <td style="height: 40px;"></td>
                </tr>
                <tr>
                    <td style="height: 40px;">1st Floor, DLF Square, Jacaranda Marg </td>
                    <td style="height: 40px;"></td>
                    <td style="height: 40px;">INV NO. : <u>123456789</u></td>
                </tr>
                <tr>
                    <td style="height: 40px;">DLF Phase 2, Gurgaon Haryana 122002 , India</td>
                    <td style="height: 40px;"></td>
                    <td style="height: 40px;">GSTN :<u>56582548</u> </td>
                </tr>
                <tr>
                    <td style="height: 40px;"><b>GSTN - 06AAFCM1460J1ZK</b></td>
                    <td style="height: 40px;"></td>
                    <td style="height: 40px;">C.I.N. : <u>8451284</u></td>
                </tr>
                <tr>
                    <td style="height: 40px;"><b>Place of Supply & State - <span runat="server" id="Spn_State"></span> </b></td>
                    <td style="height: 40px;"></td>
                    <td id="Grd14" runat="server" style="height: 40px;"><b>Partner Code:</b> <u><span runat="server" id="PartnerCode"></span></u>
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;"></td>
                    <td style="height: 40px;"></td>
                    <td style="height: 40px;"><b>SAC/HSN Code</b>- 999799</td>
                </tr>
            </table>

            <!-- header section ends here -->

            <!-- mid section start here -->
            <tr>
                <td>
                    <br />
                    <br />
                    <tr style="border: solid; border-color: #e0e0e0; border-width: 1px">
                        <td style="height: 50px; font-weight: 600;">Commission invoice for the Month of :<b><span runat="server" id="SpnMonth"></span></b>  </td>
                    </tr>

                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" align="center" style="width: 100%; border-collapse: collapse;" >


                                <tr>
                                    <td style="width: 200px; background: #e0e0e0; height: 50px; text-align: center; font-weight: 600; border: 1px #8e8e8e solid;">Particular</td>
                                    <td style="width: 200px; background: #e0e0e0; height: 50px; text-align: center; font-weight: 600; border: 1px #8e8e8e solid;">Quantity Sold</td>
                                    <td style="width: 200px; background: #e0e0e0; height: 50px; text-align: center; font-weight: 600; border: 1px #8e8e8e solid;">Commission ( % )</td>
                                    <td style="width: 200px; background: #e0e0e0; height: 50px; text-align: center; font-weight: 600; border: 1px #8e8e8e solid;">Commission Amount ( INR)</td>
                                    <td id="Grd1" runat="server" style="width: 200px; height: 50px; text-align: center;"></td>

                            </table>
                        </td>
                    </tr>
                </td>
            </tr>

            <!-- mid section ends here -->


            <!-- bottom section start here -->
            <tr>
                <td>
                    <table cellspacing="0" cellpadding="0" align="center" style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td id="Grd2" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid; border-top: none;">Total</td>
                       
                        </tr>
                        <tr>
                            <td id="Grd5" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">CGST @9.00%</td>
                   
                        </tr>
                        <tr>
                            <td id="Grd6" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">SGST @9.00%</td>
                    
                        </tr>
                        <tr>
                            <td id="Grd4" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">IGST @18.00%</td>
                        
                        </tr>
                        <tr>
                            <td id="Grd7" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">UTGST @</td>
                       
                        </tr>
                        <tr>
                            <td id="Grd8" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">Cess @</td>
                         
                        </tr>
                        <tr>
                            <td id="Grd3" runat="server" style="height: 35px; width: 50%; text-align: center; font-weight: 600; border: 1px #8e8e8e solid;">Grand Total</td>
                         
                        </tr>
                        <tr>
                            <td id="Td1" runat="server" style="height: 35px; width: 50%; text-align: center;"></td>

                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td height="40"></td>
            </tr>

            <tr>
                <td>
                    <table cellspacing="0" cellpadding="0" align="center" style="width: 100%; border-collapse: collapse;">
                        <tr>
                            <td id="Grd9" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">Amount Written in Word:</td>

                        </tr>
                        <tr>
                            <td id="Grd10" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">Name of the Authorized Person:</td>
                       
                        </tr>
                        <tr>
                            <td id="Grd11" runat="server" style="height: 35px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">Contact number of the Authorized Person:</td>
                         
                        </tr>
                        <tr>
                            <td id="Grd12" runat="server" style="height: 60px; width: 50%; text-align: center; border: 1px #8e8e8e solid;">Authorized Signatory  & Stamp:</td>
                         
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="40"></td>
            </tr>
            <br />
            <br />
            <tr>
                <td style="height: 40px; width: 50%; text-align: center;">Whether Tax payable under reverse charge - Yes / No</td>
            </tr>

            <tr>
                <td style="height: 50px;">Kindly make the payment through NEFT, as per details mentioned below. Also enclosed is cancelled cheque to validate NEFT details:</td>
            </tr>

            <tr>
                <td height="10"></td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="0" cellpadding="0" align="center" style="width: 100%; border-collapse: collapse;">


                        <tr>
                            <td style="width: 50px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">1</td>
                            <td style="width: 200px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">Beneficiary Name</td>
                            <td style="width: 550px; text-align: center; height: 35px; border: 1px #8e8e8e solid;"></td>
                        </tr>
                        <tr>
                            <td style="width: 50px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">2</td>
                            <td style="width: 200px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">Bank Account Number</td>
                            <td style="width: 550px; text-align: center; height: 35px; border: 1px #8e8e8e solid;"></td>
                        </tr>
                        <tr>
                            <td style="width: 50px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">3</td>
                            <td style="width: 200px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">Bank IFSC Code</td>
                            <td style="width: 550px; text-align: center; height: 35px; border: 1px #8e8e8e solid;"></td>
                        </tr>
                        <tr>
                            <td style="width: 50px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">4</td>
                            <td style="width: 200px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">Bank Name</td>
                            <td style="width: 550px; text-align: center; height: 35px; border: 1px #8e8e8e solid;"></td>
                        </tr>
                        <tr>
                            <td style="width: 50px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">5</td>
                            <td style="width: 200px; text-align: center; height: 35px; border: 1px #8e8e8e solid;">Bank Branch Name</td>
                            <td style="width: 550px; text-align: center; height: 35px; border: 1px #8e8e8e solid;"></td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td height="30"></td>
            </tr>
            <!-- bottom section start here -->
        </table>
    </div>
    <%--   </form>--%>
</body>
</html>

