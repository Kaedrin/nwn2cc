using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.Windows.Forms;

namespace NWN2ToolKit
{
    public class StormTools
    {
        public string sDataPath = "";
        public DataGridView _dataGridView1;
        public StringBuilder columnrow;
        public ArrayList HeaderData = new ArrayList();
        public ArrayList ParsedFile = new ArrayList();
        public string sFileInputName;
        public ManagedNWScript.ManagedScriptCompiler _MSC;
        public List<int> iList = new List<int>();
        public int iRemoved = 0;
        public int iLabelColumn = -1;

        #region Change Data Path
        public bool ValidatePath(string sPath)
        {
            bool isValid = true;
            string sFileToCheck;

            sFileToCheck = sDataPath + @"\spells.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;
            sFileToCheck = sDataPath + @"\feat.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;
            sFileToCheck = sDataPath + @"\racialsubtypes.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;
            sFileToCheck = sDataPath + @"\armorrulestats.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;
            sFileToCheck = sDataPath + @"\domains.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;
            sFileToCheck = sDataPath + @"\packages.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;
            sFileToCheck = sDataPath + @"\classes.2da";
            if (!System.IO.File.Exists(sFileToCheck))
                isValid = false;

            return isValid;
        }

        #endregion

        #region Integrate Content

        private void buttonIntegrateContent_Click(object sender, EventArgs e)
        {
            IntegrateContent();
        }

        public bool InjectCMICode(string sScript, string sEvent, OEIShared.IO.ERF.ERFFile _ERFFile)
        {
            bool bFound = false;
            foreach (OEIShared.IO.ERF.ERFResource r in _ERFFile.Resources)
            {
                if (r.FullName.ToUpper() == (sScript.ToUpper() + ".NSS"))
                {
                    //Parse
                    r.SaveData(sDataPath + @"\" + r.FullName);
                    bFound = true;
                    UpdateScript(sScript, sEvent);
                }
            }
            return bFound;
        }

        public void UpdateScript(string sScript, string sEvent)
        {
            string sFile = sDataPath + @"\" + sScript + ".nss";
            string sFile2 = sDataPath + @"\" + sScript + "a.nss";

            ArrayList UpdatedFile = new ArrayList();
            bool bCMICodeFound = false;
            int iRow = 0;
            int iMainRow = 0;
            using (System.IO.StreamReader sr = new

                System.IO.StreamReader(sFile))
            {

                while (!sr.EndOfStream)
                {
                    string sValue = sr.ReadLine();
                    if (sValue.Contains("ccs_"))
                        bCMICodeFound = true;
                    if (sValue.Contains("void main()"))
                        iMainRow = iRow;
                    iRow++;
                    UpdatedFile.Add(sValue);
                }
                sr.Close();
            }

            if (!bCMICodeFound)
            {

                switch (sEvent)
                {
                    /*
                    k_mod_player_unequip
                    k_mod_pc_loaded
                    k_mod_player_rest
                    k_mod_heartbeat
                    k_mod_start
                    k_mod_player_levelup
                    k_mod_player_equip
                    */
                    case "k_mod_player_unequip":
                        {
                            string s1 = @"object oCMI_PC = GetPCItemLastUnequippedBy();";
                            string s2 = @"ExecuteScript(""ccs_player_unequip"", oCMI_PC);";


                            UpdatedFile.Insert(iMainRow + 2, s2);
                            UpdatedFile.Insert(iMainRow + 2, s1);
                        }
                        break;

                    default:
                        break;

                }

            }


            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFile2))
            {

                foreach (string s in UpdatedFile)
                {
                    sw.WriteLine(s);
                }




                sw.Close();
            }

            _MSC.CompileFile(sScript + "a", sDataPath + @"\");

        }


        public void IntegrateContent()
        {
            OEIShared.IO.ERF.ERFFile _ERFFile = new OEIShared.IO.ERF.ERFFile(sDataPath + @"\" + "e.mod", true);

            foreach (OEIShared.IO.ERF.ERFResource r in _ERFFile.Resources)
            {
                if (r.FullName.ToUpper() == "MODULE.IFO")
                {
                    r.SaveData(sDataPath + @"\" + "gg.ifo");
                }
            }
            OEIShared.IO.GFF.GFFFile _GF = new OEIShared.IO.GFF.GFFFile();
            _GF.Open(sDataPath + @"\" + "gg.ifo");
            foreach (System.Collections.DictionaryEntry gf in _GF.TopLevelStruct.Fields)
            {
                if (gf.Key.ToString() == "Mod_OnPlrUnEqItm")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_player_unequip";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }

                }
                else if (gf.Key.ToString() == "Mod_OnPCLoaded")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_pc_loaded";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }
                }
                else if (gf.Key.ToString() == "Mod_OnPlrRest")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_player_rest";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }
                }
                else if (gf.Key.ToString() == "Mod_OnHeartbeat")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_heartbeat";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }
                }
                else if (gf.Key.ToString() == "Mod_OnModStart")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_start";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }
                }
                else if (gf.Key.ToString() == "Mod_OnPlrLvlUp")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_player_levelup";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }
                }
                else if (gf.Key.ToString() == "Mod_OnPlrEqItm")
                {
                    OEIShared.IO.GFF.GFFResRefField _ResRefField = (OEIShared.IO.GFF.GFFResRefField)gf.Value;
                    OEIShared.Utils.OEIResRef _ResRef = (OEIShared.Utils.OEIResRef)_ResRefField.Value;
                    string sEvent = "k_mod_player_equip";
                    if (_ResRef.Value == "")
                        _ResRef.Value = sEvent;
                    else
                    {
                        if (_ResRef.Value != sEvent)
                        {
                            bool bTweaked = InjectCMICode(_ResRef.Value, sEvent, _ERFFile);
                            if (!bTweaked)
                                _ResRef.Value = sEvent;
                        }
                    }
                }
                //else if (gf.Key.ToString() == "Mod_OnModLoad")
                //{

                //}
                //else if (gf.Key.ToString() == "Mod_OnClientEntr")
                //{

                //}

            }
            _GF.Save(sDataPath + @"\" + "gg.ifo");
            GC.Collect();
        }
        #endregion

        #region Generate MP Files

        private void MakeMPHenComp()
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[3].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[3].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[3].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[4].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[4].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[4].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }


        private void MakeMPBaseItems()
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[1].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[1].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[1].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[33].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[33].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[33].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[48].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[48].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[48].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }


        private void MakeMPPackages()
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if ((CurrentLine.Index != (_dataGridView1.Rows.Count - 1)) && (CurrentLine.Index != 249))
                    {
                        if (!CurrentLine.Cells[2].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[2].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[2].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[3].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[3].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[3].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }


        private void MakeMPDomains()
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[2].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[2].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[2].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[3].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[3].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[3].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }


        private void MakeMPIPRPFeats()
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[1].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[1].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[1].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }


        private void MakeMPSpells()
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[2].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[2].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[2].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[55].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[55].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[55].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[59].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[59].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[59].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }

        public void MakePackSpells(bool bMultiplayer)
        {

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_" + bMultiplayer.ToString()))
            {
                int nBonus = 0;
                if (bMultiplayer)
                    nBonus = 16551217;

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";
                DataGridViewRow PaddedLine = new DataGridViewRow();
                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index == 1696)
                        PaddedLine = CurrentLine;

                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1) && CurrentLine.Index > 1737)
                    {
                        bool bValid = false;
                        if (!CurrentLine.Cells[2].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[2].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[2].Value = lVal + nBonus;
                            }
                        }
                        if (!CurrentLine.Cells[55].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[55].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[55].Value = lVal + nBonus;
                            }
                        }
                        if (!CurrentLine.Cells[59].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[59].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[59].Value = lVal + nBonus;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        if (!CurrentLine.Cells[10].Value.ToString().Contains("*"))
                            bValid = true;
                        if (!CurrentLine.Cells[11].Value.ToString().Contains("*"))
                            bValid = true;
                        if (!CurrentLine.Cells[12].Value.ToString().Contains("*"))
                            bValid = true;
                        if (!CurrentLine.Cells[13].Value.ToString().Contains("*"))
                            bValid = true;
                        if (!CurrentLine.Cells[14].Value.ToString().Contains("*"))
                            bValid = true;
                        if (!CurrentLine.Cells[15].Value.ToString().Contains("*"))
                            bValid = true;
                        if (!CurrentLine.Cells[16].Value.ToString().Contains("*"))
                            bValid = true;
                        if (bValid)
                            sw.WriteLine(linew);
                        else
                        {
                            linew = "";
                            PaddedLine.Cells[0].Value = CurrentLine.Cells[0].Value;
                            foreach (DataGridViewCell s in PaddedLine.Cells)
                            {
                                linew = linew + s.FormattedValue + "\t";
                            }
                            sw.WriteLine(linew);
                        }
                        linew = "";
                    }
                }

                sw.Close();

            }
        }


        public void MakeMPFeat()
        {
            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[2].Value.ToString().Contains("*"))
                        {
                            try
                            {
                                string ss = CurrentLine.Cells[2].Value.ToString();
                                long lVal = Convert.ToInt32(ss);
                                if (lVal >= 240000)
                                {
                                    CurrentLine.Cells[2].Value = lVal + 16551217;
                                }
                            }
                            catch
                            {
                                //Probably Aleandra
                            }
                        }
                        if (!CurrentLine.Cells[3].Value.ToString().Contains("*"))
                        {
                            try
                            {
                                string ss = CurrentLine.Cells[3].Value.ToString();
                                long lVal = Convert.ToInt32(ss);
                                if (lVal >= 240000)
                                {
                                    CurrentLine.Cells[3].Value = lVal + 16551217;
                                }
                            }
                            catch
                            {
                                //Probably Aleandra
                            }

                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }

                        //Only write out the active feats
                        /*
                        if (CurrentLine.Cells[55].Value.ToString() == "1")
                        {
                            string s = CurrentLine.Cells[60].Value.ToString();
                            if (s != "1" && s != "****")
                                sw.WriteLine(linew);
                        }
                        sw.WriteLine(linew);
                        */

                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }

        private void MakeMPRacialSubTypes()
        {
            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[5].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[5].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[5].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[6].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[6].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[6].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[7].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[7].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[7].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[8].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[8].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[8].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[9].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[9].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[9].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[10].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[10].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[10].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[11].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[11].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[11].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }

        private void MakeMPArmorRuleStats()
        {
            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[8].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[8].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[8].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[9].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[9].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[9].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[10].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[10].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[10].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }

        private void MakeMPClasses()
        {
            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sFileInputName + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";

                foreach (DataGridViewRow CurrentLine in _dataGridView1.Rows)
                {
                    if (CurrentLine.Index != (_dataGridView1.Rows.Count - 1))
                    {
                        if (!CurrentLine.Cells[2].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[2].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[2].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[3].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[3].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[3].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[4].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[4].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[4].Value = lVal + 16551217;
                            }
                        }
                        if (!CurrentLine.Cells[5].Value.ToString().Contains("*"))
                        {
                            string ss = CurrentLine.Cells[5].Value.ToString();
                            long lVal = Convert.ToInt32(ss);
                            if (lVal >= 240000)
                            {
                                CurrentLine.Cells[5].Value = lVal + 16551217;
                            }
                        }
                        foreach (DataGridViewCell s in CurrentLine.Cells)
                        {
                            linew = linew + s.FormattedValue + "\t";
                        }
                        sw.WriteLine(linew);
                        linew = "";
                    }
                }

                sw.Close();

            }
        }

        public void GenerateMPFiles(ProgressBar _progressBarStatus)
        {
            sFileInputName = sDataPath + @"\iprp_feats.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPIPRPFeats();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\spells.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPSpells();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\feat.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPFeat();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\racialsubtypes.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPRacialSubTypes();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\armorrulestats.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPArmorRuleStats();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\classes.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPClasses();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\domains.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPDomains();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\packages.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPPackages();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\baseitems.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPBaseItems();
            }
            _progressBarStatus.Value++;

            sFileInputName = sDataPath + @"\hen_companion.2da";
            if (System.IO.File.Exists(sFileInputName))
            {
                ParseFile(sFileInputName);
                LoadParsedFileToDataGrid(false);
                MakeMPHenComp();
            }
            _progressBarStatus.Value++;


        }

        #endregion

        public void LoadParsedFileToDataGrid(bool bAllColumnsVisible)
        {
            if (ParsedFile.Count > 0)
            {
                int i = 0;
                columnrow = new StringBuilder();
                _dataGridView1.Rows.Clear();
                _dataGridView1.Columns.Clear();

                foreach (string column in (ArrayList)ParsedFile[0])
                {

                    DataGridViewTextBoxColumn dgvColumn = new DataGridViewTextBoxColumn();
                    dgvColumn.Name = column;
                    _dataGridView1.Columns.Add(dgvColumn);
                    columnrow.Append(column);
                    columnrow.Append("\t");
                }

                foreach (DataGridViewTextBoxColumn dgvColumn in _dataGridView1.Columns)
                {
                    string sColumnName = dgvColumn.Name.ToLower();
                    if (sColumnName == "name" || sColumnName == "spelldesc" || sColumnName == "row no." || sColumnName == "feat" || sColumnName == "descriptions"
                        || sColumnName == "baseitemstatref" || sColumnName == "description" || sColumnName == "plural" || sColumnName == "lower")
                    {
                        dgvColumn.ReadOnly = true;
                    }
                    else
                        if (sColumnName == "label")
                    {
                        dgvColumn.MinimumWidth = 300;
                        dgvColumn.ReadOnly = true;
                        iLabelColumn = dgvColumn.Index;
                    }
                    else
                            if (sColumnName == "removed")
                    {
                        iRemoved = dgvColumn.Index;
                        // Do nothing, we want it visible
                    }
                    else if (sColumnName == "row no.")
                    {
                        // Do nothing, we want it visible
                    }
                    else
                    {
                        dgvColumn.Visible = bAllColumnsVisible;
                    }
                }

                i = 0;
                foreach (ArrayList row in (ArrayList)ParsedFile)
                {

                    string[] temp = (string[])row.ToArray(typeof(string));
                    //dataGridView1.Rows.Add(row);
                    if (i != 0)
                    {
                        _dataGridView1.Rows.Add(temp);
                    }
                    i++;
                }
                _dataGridView1.Update();
            }
            else
                MessageBox.Show("Error #0001 parsing the 2da file.");
        }

        public void ParseFile(string sFileName)
        {
            ParsedFile.Clear();

            try
            {

                using (System.IO.StreamReader sr = new

                    System.IO.StreamReader(sFileName))
                {

                    string line;

                    int iLineNum = 1;
                    while ((line = sr.ReadLine()) != null)
                    {

                        ArrayList ParsedLine = new ArrayList();
                        if (iLineNum > 2)
                        {
                            if (iLineNum == 3)
                                ParsedLine.Add("");
                            char[] currentLine = line.ToCharArray();
                            StringBuilder sColumn = new StringBuilder();
                            foreach (char c in currentLine)
                            {
                                if (0 != c.CompareTo((char)32) && (!Char.IsControl(c)))
                                    sColumn.Append(c);
                                else
                                {
                                    if (sColumn.ToString() != "")
                                        ParsedLine.Add(sColumn.ToString());
                                    sColumn = new StringBuilder();
                                }

                            }

                            if (sColumn.ToString() != "")
                                ParsedLine.Add(sColumn.ToString());
                            ParsedFile.Add(ParsedLine);



                        }

                        else
                        {

                            HeaderData.Add(line);

                        }
                        iLineNum++;

                    }
                    sr.Close();
                }

            }

            catch (Exception eError)
            {

                string error;

                error = "Failed in ReadTTLFileData: " + eError.ToString();

                Console.WriteLine(error);

            }
        }

        #region Generate IPRPSpells

        public bool IsPlannedCL(int iVal)
        {
            if (iList.Contains(iVal))
                return true;
            else
                return false;
        }

        public void ResetList()
        {
            iList.Clear();
            iList.Add(1);
            iList.Add(3);
            iList.Add(5);
            iList.Add(7);
            iList.Add(9);
            iList.Add(11);
            iList.Add(13);
            iList.Add(15);
            iList.Add(17);
            iList.Add(20);
            iList.Add(21);
            iList.Add(24);
            iList.Add(27);
            iList.Add(30);
        }

        public void CleanListBySpellLevel(int SpellLevel)
        {
            List<int> iNewList = new List<int>();
            int iCLMin = SpellLevel * 2 - 1;
            foreach (int iVal in iList)
            {
                if (iVal >= iCLMin)
                    iNewList.Add(iVal);
            }
            iList = iNewList;
        }

        public bool isValidSpell(OEIShared.IO.TwoDA.TwoDAFile _File, int iSpellId)
        {
            if (_File.Columns[67].LiteralValue(iSpellId) == "****" || _File.Columns[67].LiteralValue(iSpellId) == "1")
                return false;

            bool bValid = false;
            for (int i = 9; i < 16; i++)
            {
                //OEIShared.IO.TwoDA.TwoDAColumn _Column = _File.Columns[i].l;
                string s = _File.Columns[i].LiteralValue(iSpellId);
                if (s != "****")
                    bValid = true;
            }

            return bValid;
        }

        public List<int> GenerateSpellsNotUsed(OEIShared.IO.TwoDA.TwoDAFile _File, List<int> _SpellsUsed)
        {
            List<int> _SpellsNotUsed = new List<int>();
            for (int i = 0; i < _File.RowCount; i++)
            {
                string s = _File.Columns[67].LiteralValue(i);
                if (_File.Columns[67].LiteralValue(i) != "1" && !_SpellsUsed.Contains(i))
                {
                    if (isValidSpell(_File, i))
                        _SpellsNotUsed.Add(i);
                }
            }
            return _SpellsNotUsed;
        }

        public int CalcCost(int SL, int CL)
        {
            int iCost = 0;
            float fPrevSL = 0f;
            int iPrevCL = 0;
            int iCL = 0;
            float fSL = 0f;

            for (int iCount1 = 1; iCount1 <= CL; iCount1++)
            {
                int Current = (iCount1 - 1) * 245 + 345 + iPrevCL;
                iCL = Current;
                iPrevCL = Current;
            }

            if (SL > 0)
            {
                for (int iCount2 = 1; iCount2 <= SL; iCount2++)
                {
                    float Current = ((iCount2 - 1) * 1800) + 727.5f + fPrevSL;
                    fSL = Current;
                    fPrevSL = Current;
                }
            }
            else
            {
                iCost = 200;
            }
            iCost = iCL + (int)(fSL + 0.5f);


            return iCost;
        }

        bool isStringValidSpell(string s)
        {
            bool bTrue = false;
            if (s == "1") bTrue = true;
            if (s == "2") bTrue = true;
            if (s == "3") bTrue = true;
            if (s == "4") bTrue = true;
            if (s == "5") bTrue = true;
            if (s == "6") bTrue = true;
            if (s == "7") bTrue = true;
            if (s == "8") bTrue = true;
            if (s == "9") bTrue = true;

            return bTrue;
        }

        public void BuildIPRPSpells()
        {
            string sSpells = sDataPath + @"\spells.2da";
            string sIPRP = sDataPath + @"\i.2da";
            OEIShared.IO.TwoDA.TwoDAFile _File = new OEIShared.IO.TwoDA.TwoDAFile(sSpells);

            ParseFile(sSpells);
            ArrayList ParsedFileSpells = new ArrayList();
            foreach (ArrayList row in (ArrayList)ParsedFile)
            {
                if ( (row[0] != "") && (System.Convert.ToInt16(row[0]) > 1212))
                {
                    if (isStringValidSpell((string)row[10]) || isStringValidSpell((string)row[11]) || isStringValidSpell((string)row[12]) || isStringValidSpell((string)row[13]) || isStringValidSpell((string)row[14]) || isStringValidSpell((string)row[15]) || isStringValidSpell((string)row[16]))
                    {
                        if (((string)row[1] != "****") && ((string)row[68] != "-1")  )
                            ParsedFileSpells.Add(row);
                    }
                }
            }



            ParseFile(sIPRP);



            int i = 0;
            int iLast = -1;
            ArrayList NewData = new ArrayList();
            ArrayList _LastRow = null;
            List<int> _SpellsUsed = new List<int>();
            ResetList();
            //ParsedFile.Sort(1,ParsedFile.Count - 1, null);
            ArrayList ParsedFile2 = new ArrayList();
            int erroryes = 0;

            for (int ix = 0; ix < _File.RowCount; ix++)
            {
                foreach (ArrayList row in (ArrayList)ParsedFile)
                {
                    if ((string)row[6] == ix.ToString() || (string)row[6] == "****" || (string)row[6] == "" || (string)row[6] == "-1")
                    {
                        if ((string)row[1] != "****")
                            ParsedFile2.Add(row);
                    }
                }
            }

            foreach (ArrayList row in (ArrayList)ParsedFile2)
            {
                if (i != -1)
                {
                    if ((string)row[6] == "****" || (string)row[6] == "" || (string)row[6] == "-1")
                    {
                        for (int j = 1; j < row.Count; j++)
                        {
                            row[j] = "****";
                        }
                    }
                    else
                    {
                        if ((string)row[1] == "Bless_Weapon")
                        {
                            int iv = 0;
                        }
                        if ((string)row[6] == iLast.ToString())
                        {
                            int iCL = System.Convert.ToInt16(row[3]);
                            if (IsPlannedCL(iCL))
                            {
                                iList.Remove(iCL);
                            }
                        }
                        else
                        {
                            if (iLast != -1)
                            {
                                if ((string)_LastRow[4] != "0.5")
                                    CleanListBySpellLevel(System.Convert.ToInt16(_LastRow[4]));
                                else
                                    CleanListBySpellLevel(1);

                                if (isValidSpell(_File, System.Convert.ToInt16(_LastRow[6])))
                                {
                                    if (iList.Count > 0)
                                        _SpellsUsed.Add(System.Convert.ToInt16(_LastRow[6]));
                                    foreach (int iNewCL in iList)
                                    {
                                        ArrayList _NewRow = (ArrayList)_LastRow.Clone();
                                        _NewRow[3] = iNewCL.ToString();

                                        NewData.Add(_NewRow);
                                    }
                                }
                                ResetList();

                                int iCL = System.Convert.ToInt16(row[3]);
                                if (IsPlannedCL(iCL))
                                {
                                    iList.Remove(iCL);
                                }
                                iLast = System.Convert.ToInt16(row[6]);
                                _LastRow = row;
                            }
                            else
                            {
                                int iCL = System.Convert.ToInt16(row[3]);
                                if (IsPlannedCL(iCL))
                                {
                                    iList.Remove(iCL);
                                }
                                iLast = System.Convert.ToInt16(row[6]);
                                _LastRow = row;
                            }

                        }

                    }
                }
                i++;
            }
            i = 0;

            foreach (ArrayList row in (ArrayList)NewData)
            {
                int SL = 0;
                if ((string)row[4] == "0.5")
                    SL = 1;
                else
                    SL = System.Convert.ToInt16(row[4]);
                int CL = System.Convert.ToInt16(row[3]);
                row[5] = (string)CalcCost(SL, CL).ToString();
            }

            int iPRPRow = 739;
            foreach (ArrayList row in (ArrayList)NewData)
            {
                row[0] = iPRPRow.ToString();
                iPRPRow++;
            }

            ParsedFile.AddRange(NewData);
            _SpellsUsed.Sort();
            List<int> _SpellsNotUsed = new List<int>();
            _SpellsNotUsed = GenerateSpellsNotUsed(_File, _SpellsUsed);

            StringBuilder columnrow = new StringBuilder();
            foreach (string column in (ArrayList)ParsedFile[0])
            {
                columnrow.Append(column);
                columnrow.Append("\t");
            }

            ArrayList UpdatedFile = new ArrayList();
            using (System.IO.StreamWriter sw = new

                System.IO.StreamWriter(sIPRP + "_"))
            {

                sw.WriteLine("2DA\tV2.0");
                sw.WriteLine();
                sw.WriteLine(columnrow.ToString());
                string linew = "";
                int iii = 0;
                foreach (ArrayList row in (ArrayList)ParsedFile)
                {
                    linew = "";
                    if (i > 0)
                    {
                        if ((string)row[6] != "****")
                        {
                            int iSpellId = System.Convert.ToInt16(row[6]);
                            string sx = _File.Columns[16].LiteralValue(iSpellId);

                            if ((string)row[4] != sx)
                                iii++;
                            if (sx == "0")
                                sx = "1";
                            if (sx != "****")
                                row[4] = sx;
                        }

                        string[] temp = (string[])row.ToArray(typeof(string));

                        for (int j = 0; j < row.Count; j++)
                        {
                            linew = linew + row[j] + "\t";
                        }
                        sw.WriteLine(linew);
                    }
                    i++;
                }
                sw.Close();

            }

            OEIShared.IO.TalkTable.TalkTableFile tlkFile = new OEIShared.IO.TalkTable.TalkTableFile();
            tlkFile.Open(sDataPath + @"\Dialog.tlk", false);
            tlkFile.Language = OEIShared.Utils.BWLanguages.BWLanguage.English;

            List<string> _STitles = new List<string>();
            int ivCount = -1;
            foreach (ArrayList row in (ArrayList)ParsedFile)
            {

                if ((string)row[6] != "SpellIndex" && (string)row[6] != "****")
                {
                    int iSpellId = System.Convert.ToInt16(row[6]);
                    string sSpell = _File.Columns[0].LiteralValue(iSpellId);

                    string sSpell2 = _File.Columns[1].LiteralValue(iSpellId);
                    long iiix = 0;
                    if (sSpell2 != "****")
                    {
                        iiix = System.Convert.ToInt32(sSpell2);
                        //long iiix; = System.Convert.ToInt32(_File.Columns[1].LiteralValue(iSpellId));
                        sSpell2 = tlkFile.Elements[(int)iiix].String;
                        int iText = System.Convert.ToInt16(row[6]);
                        string sText = sSpell + " (" + (string)row[3] + ")";
                        _STitles.Add(sText);
                    }
                }
                ivCount++;
            }
            int iiv = _STitles.Count;
        }

        #endregion

        public void CompileScript(string sName, string sOutputPath)
        {
            sOutputPath = sDataPath;
            _MSC.CompileFile(sName, sOutputPath);
            GC.Collect();
        }


    }
}
