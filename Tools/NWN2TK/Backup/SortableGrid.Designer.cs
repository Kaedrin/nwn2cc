namespace NWN2ToolKit
{
    partial class SortableGrid
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.buttonResetSort = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.buttonFindInGrid = new System.Windows.Forms.Button();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.checkBoxFilterRemoved = new System.Windows.Forms.CheckBox();
            this.textBoxSortText = new System.Windows.Forms.TextBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // buttonResetSort
            // 
            this.buttonResetSort.Location = new System.Drawing.Point(573, 8);
            this.buttonResetSort.Name = "buttonResetSort";
            this.buttonResetSort.Size = new System.Drawing.Size(75, 23);
            this.buttonResetSort.TabIndex = 14;
            this.buttonResetSort.Text = "Reset Grid";
            this.buttonResetSort.UseVisualStyleBackColor = true;
            this.buttonResetSort.Click += new System.EventHandler(this.buttonResetSort_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(9, 340);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 10;
            this.label1.Text = "label1";
            // 
            // buttonFindInGrid
            // 
            this.buttonFindInGrid.Location = new System.Drawing.Point(492, 8);
            this.buttonFindInGrid.Name = "buttonFindInGrid";
            this.buttonFindInGrid.Size = new System.Drawing.Size(75, 23);
            this.buttonFindInGrid.TabIndex = 13;
            this.buttonFindInGrid.Text = "Find";
            this.buttonFindInGrid.UseVisualStyleBackColor = true;
            this.buttonFindInGrid.Click += new System.EventHandler(this.buttonFindInGrid_Click);
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(386, 12);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(100, 20);
            this.textBox2.TabIndex = 12;
            // 
            // checkBoxFilterRemoved
            // 
            this.checkBoxFilterRemoved.AutoSize = true;
            this.checkBoxFilterRemoved.Location = new System.Drawing.Point(283, 12);
            this.checkBoxFilterRemoved.Name = "checkBoxFilterRemoved";
            this.checkBoxFilterRemoved.Size = new System.Drawing.Size(97, 17);
            this.checkBoxFilterRemoved.TabIndex = 11;
            this.checkBoxFilterRemoved.Text = "Filter Removed";
            this.checkBoxFilterRemoved.UseVisualStyleBackColor = true;
            this.checkBoxFilterRemoved.CheckedChanged += new System.EventHandler(this.checkBoxFilterRemoved_CheckedChanged);
            // 
            // textBoxSortText
            // 
            this.textBoxSortText.Location = new System.Drawing.Point(12, 12);
            this.textBoxSortText.Name = "textBoxSortText";
            this.textBoxSortText.Size = new System.Drawing.Size(265, 20);
            this.textBoxSortText.TabIndex = 9;
            this.textBoxSortText.TextChanged += new System.EventHandler(this.textBoxSortText_TextChanged);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.AllowUserToResizeRows = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(12, 48);
            this.dataGridView1.MultiSelect = false;
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(662, 273);
            this.dataGridView1.TabIndex = 8;
            this.dataGridView1.RowEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_RowEnter);
            // 
            // SortableGrid
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(686, 374);
            this.Controls.Add(this.buttonResetSort);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.buttonFindInGrid);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.checkBoxFilterRemoved);
            this.Controls.Add(this.textBoxSortText);
            this.Controls.Add(this.dataGridView1);
            this.Name = "SortableGrid";
            this.Text = "Sortable Grid";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.SortableGrid_Load);
            this.Resize += new System.EventHandler(this.SortableGrid_Resize);
            this.ResizeEnd += new System.EventHandler(this.SortableGrid_ResizeEnd);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonResetSort;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button buttonFindInGrid;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.CheckBox checkBoxFilterRemoved;
        private System.Windows.Forms.TextBox textBoxSortText;
        public System.Windows.Forms.DataGridView dataGridView1;
    }
}