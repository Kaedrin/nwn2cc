using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace NWN2ToolKit
{
    public partial class SortableGrid : Form
    {
        List<DataGridViewRow> Orig_DGVRList;
        public StormTools _STools;

        public SortableGrid()
        {
            InitializeComponent();
        }

        private void buttonFindInGrid_Click(object sender, EventArgs e)
        {
            string sFind = textBox2.Text.ToLower();
            if (sFind != "")
            {
                bool bFound = false;
                int iRowCount = dataGridView1.Rows.Count;
                for (int iToEnd = dataGridView1.CurrentRow.Index; iToEnd < iRowCount; iToEnd++)
                {
                    DataGridViewRow _Row = dataGridView1.Rows[iToEnd];
                    if (_Row.Index != dataGridView1.CurrentRow.Index)
                    {
                        if (_Row.Cells[1].Value.ToString().ToLower().Contains(sFind))
                        {
                            dataGridView1.ClearSelection();
                            _Row.Selected = true;
                            bFound = true;
                            dataGridView1.CurrentCell = _Row.Cells[1];
                            break;
                        }
                    }
                }
                if (!bFound)
                {
                    for (int iBegin = 0; iBegin < dataGridView1.CurrentRow.Index; iBegin++)
                    {
                        DataGridViewRow _Row = dataGridView1.Rows[iBegin];
                        if (_Row.Index != dataGridView1.CurrentRow.Index)
                        {
                            if (_Row.Cells[1].Value.ToString().ToLower().Contains(sFind))
                            {
                                dataGridView1.ClearSelection();
                                _Row.Selected = true;
                                bFound = true;
                                dataGridView1.CurrentCell = _Row.Cells[1];
                                break;
                            }
                        }
                    }
                }
                if (bFound)
                {
                    if (dataGridView1.CurrentCell != null)
                        label1.Text = "2DA Row: " + dataGridView1.Rows[dataGridView1.CurrentRow.Index].Cells[0].Value.ToString();
                }
            }
        }

        private void buttonResetSort_Click(object sender, EventArgs e)
        {
            dataGridView1.Rows.Clear();
            foreach (DataGridViewRow _Row in Orig_DGVRList)
            {
                dataGridView1.Rows.Add(_Row);
            }
            dataGridView1.Update();
        }

        private void SortableGrid_Load(object sender, EventArgs e)
        {
            Orig_DGVRList = new List<DataGridViewRow>();
            foreach (DataGridViewRow _Row in dataGridView1.Rows)
            {
                Orig_DGVRList.Add(_Row);
            }
        }

        private void checkBoxFilterRemoved_CheckedChanged(object sender, EventArgs e)
        {
            List<DataGridViewRow> _DGVRList = new List<DataGridViewRow>();
            if (checkBoxFilterRemoved.Checked)
            {
                foreach (DataGridViewRow _Row in Orig_DGVRList)
                {
                    if (!(_Row.Cells[_STools.iRemoved].Value.ToString() == "1" || _Row.Cells[_STools.iRemoved].Value.ToString() == "****"))
                        _DGVRList.Add(_Row);
                }
            }
            else
            {
                _DGVRList = Orig_DGVRList;
            }
            dataGridView1.Rows.Clear();
            foreach (DataGridViewRow _Row in _DGVRList)
            {
                dataGridView1.Rows.Add(_Row);
            }
            dataGridView1.Update();
        }

        private void textBoxSortText_TextChanged(object sender, EventArgs e)
        {
            int iLabelColumn = 1;
            if (_STools.iLabelColumn != -1)
                iLabelColumn = _STools.iLabelColumn;
            List<DataGridViewRow> _DGVRList = new List<DataGridViewRow>();
            if (textBoxSortText.Text == "")
            {
                _DGVRList = Orig_DGVRList;
            }
            else
            {
                foreach (DataGridViewRow _Row in Orig_DGVRList)
                {
                    bool bAdd = false;
                    string s = _Row.Cells[iLabelColumn].Value.ToString().ToLower();
                    if (!s.Contains(textBoxSortText.Text.ToLower()))
                        bAdd = false;
                    else
                        bAdd = true;
                    if (bAdd)
                        _DGVRList.Add(_Row);
                }
            }
            dataGridView1.Rows.Clear();
            foreach (DataGridViewRow _Row in _DGVRList)
            {
                dataGridView1.Rows.Add(_Row);
            }
            dataGridView1.Update();
        }

        private void dataGridView1_RowEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (dataGridView1.CurrentCell != null)
                label1.Text = "2DA Row: " + dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
        }

        private void SortableGrid_Resize(object sender, EventArgs e)
        {
            ResizeForm();
        }

        private void SortableGrid_ResizeEnd(object sender, EventArgs e)
        {
            ResizeForm();
        }

        private void ResizeForm()
        {
            if (this.Size.Width >= this.MinimumSize.Width || this.Size.Height >= this.MinimumSize.Height)
            {
                Size _SZ = new Size();
                _SZ = dataGridView1.Size;
                _SZ.Width = this.Size.Width - 32;
                _SZ.Height = this.Size.Height - 87 - 48;
                dataGridView1.Size = _SZ;
                Point _Loc = new Point();
                _Loc = label1.Location;
                _Loc.Y = this.Height - 68;
                label1.Location = _Loc;
            }
        }
    }
}
