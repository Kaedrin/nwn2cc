using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

//Added Microsoft
using System.Collections;
using System.Xml;

//OEI
using NWN2Toolset.Plugins;
using TD.SandBar;

namespace NWN2ToolKit
{
    public partial class NWN2TK : Form
    {
        private StormTools _STools;

        private void InitializeOEI()
        {
            new NWN2Toolset.NWN2.IO.NWN2ResourceManager();
            NWN2Toolset.NWN2.IO.NWN2ResourceManager.Instance.LoadStandardResources();

            OEIShared.IO.DirectoryResourceRepository repModule = new OEIShared.IO.DirectoryResourceRepository(Application.StartupPath);
            NWN2Toolset.NWN2.IO.NWN2ResourceManager.Instance.AddRepository(repModule);

            _STools._MSC = new ManagedNWScript.ManagedScriptCompiler();
            int _Pos = Application.StartupPath.IndexOf(@"bin\");
            labelDataPath2.Text = Application.StartupPath.Substring(0, _Pos) + "Data";
            _STools.sDataPath = labelDataPath2.Text;
            _STools.sDataPathOutput = Application.StartupPath.Substring(0, _Pos) + "MP";
        }

        public NWN2TK()
        {
            InitializeComponent();

            _STools = new StormTools();
            _STools._dataGridView1 = dataGridView1;
            _STools.sDataPath = labelDataPath2.Text;

            InitializeOEI();

            progressBarStatus.Maximum = 13;
        }

        private void buttonGenerateMPFiles_Click(object sender, EventArgs e)
        {
            progressBarStatus.Value = 0;
            _STools.GenerateMPFiles(progressBarStatus);
        }

        private void buttonBuildIPRPSpells_Click(object sender, EventArgs e)
        {
            progressBarStatus.Value = 0;
            _STools.BuildIPRPSpells();
            progressBarStatus.Value = 10;
        }

        private void buttonShowSortableGrid_Click(object sender, EventArgs e)
        {
            string _2DAName = Application.StartupPath + @"\" + label2DAName.Text;
#if DEBUG
            {
                _2DAName = _2DAName.Replace(@"bin\Debug\", @"Data\");
            }
#else
            {
                _2DAName = _2DAName.Replace(@"bin\Release\", @"Data\");
            }
#endif

            try
            {
                if (!System.IO.File.Exists(_2DAName))
                {
                    MessageBox.Show("The file " + label2DAName.Text + " does not exist in the " + Application.StartupPath + @"\Data\" + " folder.");
                    _2DAName = "";
                }
            }
            catch
            {
                MessageBox.Show("The file " + label2DAName.Text + " does not exist in the " + Application.StartupPath + @"\Data\" + " folder.");
                _2DAName = "";
            }

            if (_2DAName != "")
            {
                SortableGrid _F4 = new SortableGrid();
                _F4._STools = _STools;


                _STools._dataGridView1 = _F4.dataGridView1;
                _F4._STools.sFileInputName = _STools.sDataPath + @"\" + label2DAName.Text;
                _F4._STools.ParseFile(_STools.sFileInputName);
                _F4._STools.LoadParsedFileToDataGrid(true);

                _F4.ShowDialog();
            }
        }

        private void buttonChoose2DA_Click(object sender, EventArgs e)
        {
            openFileDialog1.InitialDirectory = _STools.sDataPath;
            openFileDialog1.ShowDialog();
            label2DAName.Text = openFileDialog1.SafeFileName;
        }

        private void buttonBlueprintDocumenter_Click(object sender, EventArgs e)
        {
            System.IO.StreamWriter sw = new System.IO.StreamWriter(_STools.sDataPath + @"\utc desc.txt");

            OEIShared.IO.TalkTable.TalkTableFile tlkFile = new OEIShared.IO.TalkTable.TalkTableFile();
            tlkFile.Open(_STools.sDataPath + @"\Dialog.tlk", false);
            tlkFile.Language = OEIShared.Utils.BWLanguages.BWLanguage.English;
            OEIShared.IO.TalkTable.TalkTableElementCollection tlkElements1 = tlkFile.Elements;

            OEIShared.IO.GFF.GFFFile _GF = new OEIShared.IO.GFF.GFFFile();
            _GF.Open(_STools.sDataPath + @"\aa.utc");

            OEIShared.IO.GFF.GFFOEIExoLocStringField _LocStringField;
            OEIShared.IO.GFF.GFFListField _ListField;
            OEIShared.IO.GFF.GFFByteField _ByteField;
            OEIShared.IO.GFF.GFFShortField _ShortField;
            OEIShared.IO.GFF.GFFFloatField _FloatField;
            OEIShared.IO.GFF.GFFIntField _IntField;
            OEIShared.IO.GFF.GFFWordField _WordField;
            OEIShared.IO.GFF.GFFResRefField _ResRefField;
            string _Key;
            string _Text;
            int _Index;
            string _Parse;

            string _NaturalAC = "";
            string _Dex = "";

            
            string _Name = "";
            _LocStringField = (OEIShared.IO.GFF.GFFOEIExoLocStringField)_GF.TopLevelStruct.Fields["FirstName"];
            if (_LocStringField.ValueCExoLocString.Strings.Count > 0)
                _Name = _LocStringField.ValueCExoLocString.Strings[0].Value;
            _LocStringField = (OEIShared.IO.GFF.GFFOEIExoLocStringField)_GF.TopLevelStruct.Fields["LastName"];
            if (_LocStringField.ValueCExoLocString.Strings.Count > 0)
                _Name = Name + " " + _LocStringField.ValueCExoLocString.Strings[0].Value;
            sw.WriteLine("Name: " + _Name);

            foreach (System.Collections.DictionaryEntry gf in _GF.TopLevelStruct.Fields)
            {
                _Key = gf.Key.ToString();
                if (_Key == "Str")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Con")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Cha")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Dex")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    _Dex = _Text;
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Wis")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Int")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "NaturalAC")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    _NaturalAC = _Text;
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Appearance_Type")
                {
                    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath +  @"\sr.2da"); //XTC - This should be appearance 2da
                    _WordField = (OEIShared.IO.GFF.GFFWordField)gf.Value;
                    _Text = _WordField.Value.ToString();
                    _Index = System.Convert.ToInt32(_WordField.Value.ToString());
                    _Index = 0;
                    _Index = System.Convert.ToInt32(_SR["Name"].LiteralValue(_Index)); // XTC - This is not "Name"
                    _Parse = tlkElements1[_Index].String;
                    _Parse = _Parse.Replace("\n", "}");
                    sw.WriteLine(_Key + ": " + _Parse);
                    sw.WriteLine();

                }
                if (_Key == "WalkRate")
                {
                    _IntField = (OEIShared.IO.GFF.GFFIntField)gf.Value;
                    _Text = _IntField.Value.ToString();  // XTC need to convert number into human text
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "MaxHitPoints") //Short
                {
                    _ShortField = (OEIShared.IO.GFF.GFFShortField)gf.Value;
                    _Text = _ShortField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "ChallengeRating") //Short
                {
                    _FloatField = (OEIShared.IO.GFF.GFFFloatField)gf.Value;
                    _Text = _FloatField.Value.ToString();
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "LawfulChaotic")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "GoodEvil")
                {
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                    sw.WriteLine(_Key + ": " + _Text);
                    sw.WriteLine();
                }
                if (_Key == "Description")
                {
                    _LocStringField = (OEIShared.IO.GFF.GFFOEIExoLocStringField)gf.Value;
                    _Index = System.Convert.ToInt32(_LocStringField.ValueCExoLocString.StringRef.ToString());
                    _Parse = tlkElements1[_Index].String;
                    _Parse = _Parse.Replace("\n", "}");
                    sw.WriteLine(_Key + ": " + _Parse);
                    sw.WriteLine();

                }
                if (_Key == "SkillList")
                {
                    sw.WriteLine("Skill List: ");
                    _ListField = (OEIShared.IO.GFF.GFFListField)gf.Value;
                    for (int ix = 0; ix < _ListField.ValueList.StructList.Count; ix++)
                    {
                        OEIShared.IO.GFF.GFFStruct _GFS = _ListField.ValueList[ix];
                        int i = _GFS.FieldCount;
                        _ByteField = (OEIShared.IO.GFF.GFFByteField)_GFS.Fields["Rank"];
                        _Text = _ByteField.Value.ToString();
                        _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                        if (_Index > 0)
                        {
                            sw.WriteLine("Skill " + ix.ToString() + ": " + _Text);
                        }
                    }
                    sw.WriteLine();
                }
                if (_Key == "SpecAbilityList")
                {
                    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath + @"\spells.2da");
                    sw.WriteLine("Special Ability List: ");
                    _ListField = (OEIShared.IO.GFF.GFFListField)gf.Value;
                    for (int ix = 0; ix < _ListField.ValueList.StructList.Count; ix++)
                    {
                        OEIShared.IO.GFF.GFFStruct _GFS = _ListField.ValueList[ix];
                        string _Spell = "";

                        _WordField = (OEIShared.IO.GFF.GFFWordField)_GFS.Fields["Spell"];
                        _Text = _WordField.Value.ToString();
                        _Index = System.Convert.ToInt32(_WordField.Value.ToString());
                        _Index = System.Convert.ToInt32(_SR["Name"].LiteralValue(_Index));
                        _Parse = tlkElements1[_Index].String;
                        _Parse = _Parse.Replace("\n", "}");
                        _Spell = _Parse + " (Caster Level ";
                        _ByteField = (OEIShared.IO.GFF.GFFByteField)_GFS.Fields["SpellCasterLevel"];
                        _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                        _Spell += _Index.ToString() + ", Users Per Day: ";
                        _ByteField = (OEIShared.IO.GFF.GFFByteField)_GFS.Fields["SpellFlags"];
                        _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                        if (_Index == 0)
                            _Spell += "Unlimited)";
                        else
                            _Spell += _Index.ToString() + ")";
                        sw.WriteLine(_Spell);
                    }
                    sw.WriteLine();
                }
                #region Equip_List
                //
                //if (_Key == "Equip_ItemList")
                //{
                //    OEIShared.IO.TwoDA.TwoDAFile _BaseItems = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath + @"\baseitems.2da");
                //    sw.WriteLine("Equipped Item List: ");
                //    _ListField = (OEIShared.IO.GFF.GFFListField)gf.Value;
                //    for (int ix = 0; ix < _ListField.ValueList.StructList.Count; ix++)
                //    {
                //        OEIShared.IO.GFF.GFFStruct _GFS = _ListField.ValueList[ix];
                //        _ResRefField = (OEIShared.IO.GFF.GFFResRefField)_GFS.Fields["EquippedRes"];
                //        _Text = _ResRefField.Value.ToString();

                //        OEIShared.IO.GFF.GFFFile _GFX = new OEIShared.IO.GFF.GFFFile();
                //        _GFX.Open(@"C:\TestApp\Data\" + _Text + ".UTI");

                //        string _Item = "";
                //        _IntField = (OEIShared.IO.GFF.GFFIntField)_GFX.TopLevelStruct.Fields["BaseItem"];
                //        _Index = System.Convert.ToInt32(_BaseItems["Name"].LiteralValue(_IntField.ValueInt));
                //        _Parse = tlkElements1[_Index].String;
                //        _Parse = _Parse.Replace("\n", "}");
                //        _Item = _Parse + "( ";

                //        OEIShared.IO.GFF.GFFListField _ListField2 = (OEIShared.IO.GFF.GFFListField)_GFX.TopLevelStruct.Fields["PropertiesList"];
                //        for (int iy = 0; iy < _ListField2.ValueList.StructList.Count; iy++) //XTC this will look the item props but needs to look it up out of the IPRP tables. Crazy/Messy/Tedious/Long.
                //        {

                //        }

                //        _Item += ")";
                //        sw.WriteLine(_Text);
                //    }


                //    sw.WriteLine();
                //}
                //
                #endregion
                if (_Key == "ClassList")
                {
                    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath + @"\classes.2da");
                    sw.WriteLine("Class List: ");
                    _ListField = (OEIShared.IO.GFF.GFFListField)gf.Value;
                    for (int ix = 0; ix < _ListField.ValueList.StructList.Count; ix++)
                    {
                        OEIShared.IO.GFF.GFFStruct _GFS = _ListField.ValueList[ix];
                        _IntField = (OEIShared.IO.GFF.GFFIntField)_GFS.Fields["Class"];
                        _Text = _IntField.Value.ToString();
                        _Index = System.Convert.ToInt32(_IntField.Value.ToString());
                        _Index = System.Convert.ToInt32(_SR["Name"].LiteralValue(_Index));
                        _Parse = tlkElements1[_Index].String;
                        _Parse = _Parse.Replace("\n", "}");
                        _ShortField = (OEIShared.IO.GFF.GFFShortField)_GFS.Fields["ClassLevel"];
                        _Text = _ShortField.Value.ToString();
                        sw.WriteLine(_Parse + ": " + _Text);
                    }
                    sw.WriteLine();
                }
                if (_Key == "FeatList")
                {
                    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath + @"\feat.2da");
                    sw.WriteLine("Feat List: ");
                    _ListField = (OEIShared.IO.GFF.GFFListField)gf.Value;
                    for (int ix = 0; ix < _ListField.ValueList.StructList.Count; ix++)
                    {
                        OEIShared.IO.GFF.GFFStruct _GFS = _ListField.ValueList[ix];
                        _WordField = (OEIShared.IO.GFF.GFFWordField)_GFS.Fields["Feat"];
                        _Text = _WordField.Value.ToString();
                        _Index = System.Convert.ToInt32(_WordField.Value.ToString());
                        _Index = System.Convert.ToInt32(_SR["Feat"].LiteralValue(_Index));
                        _Parse = tlkElements1[_Index].String;
                        _Parse = _Parse.Replace("\n", "}");
                        sw.WriteLine(_Parse);
                    }
                    sw.WriteLine();
                }

                #region Damage_Reduction
                //
                //if (_Key == "DmgReduction")
                //{
                //    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(@"C:\TestApp\Data\f.2da");
                //    sw.WriteLine("Damage Reduction: ");
                //    _ListField = (OEIShared.IO.GFF.GFFListField)gf.Value;
                //    for (int ix = 0; ix < _ListField.ValueList.StructList.Count; ix++)
                //    {
                //        OEIShared.IO.GFF.GFFStruct _GFS = _ListField.ValueList[ix];
                //        _WordField = (OEIShared.IO.GFF.GFFWordField)_GFS.Fields["Feat"];
                //        _Text = _WordField.Value.ToString();
                //        _Index = System.Convert.ToInt32(_WordField.Value.ToString());
                //        _Index = System.Convert.ToInt32(_SR["Feat"].LiteralValue(_Index));
                //        _Parse = tlkElements1[_Index].String;
                //        _Parse = _Parse.Replace("\n", "}");
                //        sw.WriteLine(_Parse);
                //    }
                //    sw.WriteLine();
                //}
                //
                #endregion

                // XTC - How to directly use a 2da!!!
                if (_Key == "Subrace")
                {
                    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath + @"\sr.2da"); //XTC - This should be subrace 2da
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                    _Index = System.Convert.ToInt32(_SR["Name"].LiteralValue(_Index));
                    _Parse = tlkElements1[_Index].String;
                    _Parse = _Parse.Replace("\n", "}");
                    sw.WriteLine(_Key + ": " + _Parse);
                    sw.WriteLine();
                }

                if (_Key == "Race")
                {
                    OEIShared.IO.TwoDA.TwoDAFile _SR = new OEIShared.IO.TwoDA.TwoDAFile(_STools.sDataPath + @"\sr.2da"); //XTC - This should be race 2da
                    _ByteField = (OEIShared.IO.GFF.GFFByteField)gf.Value;
                    _Text = _ByteField.Value.ToString();
                    _Index = System.Convert.ToInt32(_ByteField.Value.ToString());
                    _Index = System.Convert.ToInt32(_SR["Name"].LiteralValue(_Index));
                    _Parse = tlkElements1[_Index].String;
                    _Parse = _Parse.Replace("\n", "}");
                    sw.WriteLine(_Key + ": " + _Parse);
                    sw.WriteLine();
                }

                if (_Key == "")
                {
                    _Index = 0;
                }
                

            }

            int _TotalAC = ((System.Convert.ToInt32(_Dex) - 10) / 2) + 10 + (System.Convert.ToInt32(_NaturalAC));
            //XTC Need appearance lookup to get size modifier
            _Text = "Total AC: " + _TotalAC.ToString();
            sw.WriteLine(_Text);
            sw.WriteLine();

            sw.Close();
            GC.Collect();
        }

    }
}
