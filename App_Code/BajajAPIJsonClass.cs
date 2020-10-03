using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for JsonClass
/// </summary>

public class BajajJsonRequest //: IDisposable
{
    public string userid { get; set; }
    public string password { get; set; }
    public bjaztravelissue bjaztravelissue { get; set; }
    public List<familyparamlist> familyparamlist { get; set; }
    //public void Dispose()
    //{
    //    GC.SuppressFinalize(this);
    //}
}
public class bjaztravelissue
{
    public string pruralflag { get; set; }
    public string plocationcode { get; set; }
    public string ppartnerid { get; set; }
    public string pdateofbirth { get; set; }
    public string pintermediarycode { get; set; }
    public string psubagentcode { get; set; }
    public string pcovernoteno { get; set; }
    public string pfulltermpremium { get; set; }
    public string ptermstartdate { get; set; }
    public string ptermenddate { get; set; }
    public string pcoorgunit { get; set; }
    public string pservicecharge { get; set; }
    public string pspdiscountamt { get; set; }
    public string pspdiscount { get; set; }
    public string pservicetaxamt { get; set; }
    public string ptotalpremium { get; set; }
    public string pproduct { get; set; }
    public string pdestination { get; set; }
    public string pspcondition { get; set; }
    public string ppassportno { get; set; }
    public string passigneename { get; set; }
    public string pusername { get; set; }
    public string pdealercode { get; set; }
    public string ppremiumpayerflag { get; set; }
    public string ppremiumpayerid { get; set; }
    public string ppaymentmode { get; set; }
    public string pfamilyflag { get; set; }
    public string ptravelplan { get; set; }
    public string pareaplan { get; set; }
    public string pfromdate { get; set; }
    public string ploading { get; set; }
    public string pdiscount { get; set; }
    public string ptodate { get; set; }
    public string partid { get; set; }
    public string userid { get; set; }
    public string partnertype { get; set; }
    public string partnerref { get; set; }
    public string language { get; set; }
    public string addid { get; set; }
    public string regnumber { get; set; }
    public string maritalstatus { get; set; }
    public string aftertitle { get; set; }
    public string beforetitle { get; set; }
    public string contact1 { get; set; }
    public string dateofbirth { get; set; }
    public string employmentstatus { get; set; }
    public string notes { get; set; }
    public string nationalid { get; set; }
    public string sex { get; set; }
    public string telephone { get; set; }
    public string telephone2 { get; set; }
    public string email { get; set; }
    public string fax { get; set; }
    public string quality { get; set; }
    public string taxid { get; set; }
    public string vatnumber { get; set; }
    public string firstname { get; set; }
    public string surname { get; set; }
    public string institutionname { get; set; }
    public string middlename { get; set; }
    public string telephone3 { get; set; }
    public string postcode { get; set; }
    public string countrycode { get; set; }
    public string addressline1 { get; set; }
    public string addressline2 { get; set; }
    public string addressline3 { get; set; }
    public string addressline4 { get; set; }
    public string addressline5 { get; set; }
    public string checkbox { get; set; }
    public string policyno { get; set; }
    public string pmasterpolicyno { get; set; }
    public string pcompref { get; set; }
    public string pempno { get; set; }

}
public class familyparamlist //:IDisposable
{
    public string pvname { get; set; }
    public string pvage { get; set; }
    public string pvrelation { get; set; }
    public string pvsex { get; set; }
    public string pvpartnerid { get; set; }
    public string pvdob { get; set; }
    public string pvpassportno { get; set; }
    public string pvassignee { get; set; }
    //public void Dispose()
    //{
    //    GC.SuppressFinalize(this);
    //}
}
public class BajajJsonResponse
{
    public bjaztravelissue bjaztravelissue { get; set; }
    public List<familyparamlist> familyparamlist { get; set; }
    public List<coverlist> coverlist { get; set; }
    public string policyfamilylist { get; set; }
    public string policyobj { get; set; }
    public string paydtls { get; set; }
    public string agentname { get; set; }
    public string rolocationadd { get; set; }
    public List<errorlist> errorlist { get; set; }
    public int errorcode { get; set; }
}
public class coverlist
{
    public string pbenefits { get; set; }
    public string plimits { get; set; }
    public string pdeductible { get; set; }

}
public class errorlist
{
    public string errnumber { get; set; }
    public string parname { get; set; }
    public string parindex { get; set; }
    public string property { get; set; }
    public string errtext { get; set; }
    public string errlevel { get; set; }
}

