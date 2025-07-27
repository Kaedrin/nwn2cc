namespace NWN2ToolKit
{
    partial class NWN2TK
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
            this.labelDataPath1 = new System.Windows.Forms.Label();
            this.labelDataPath2 = new System.Windows.Forms.Label();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.buttonShowSortableGrid = new System.Windows.Forms.Button();
            this.buttonBuildIPRPSpells = new System.Windows.Forms.Button();
            this.buttonGenerateMPFiles = new System.Windows.Forms.Button();
            this.progressBarStatus = new System.Windows.Forms.ProgressBar();
            this.label1 = new System.Windows.Forms.Label();
            this.label2DAName = new System.Windows.Forms.Label();
            this.buttonChoose2DA = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.buttonBlueprintDocumenter = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // labelDataPath1
            // 
            this.labelDataPath1.AutoSize = true;
            this.labelDataPath1.Location = new System.Drawing.Point(12, 9);
            this.labelDataPath1.Name = "labelDataPath1";
            this.labelDataPath1.Size = new System.Drawing.Size(58, 13);
            this.labelDataPath1.TabIndex = 2;
            this.labelDataPath1.Text = "Data Path:";
            // 
            // labelDataPath2
            // 
            this.labelDataPath2.AutoSize = true;
            this.labelDataPath2.Location = new System.Drawing.Point(76, 9);
            this.labelDataPath2.Name = "labelDataPath2";
            this.labelDataPath2.Size = new System.Drawing.Size(123, 13);
            this.labelDataPath2.TabIndex = 3;
            this.labelDataPath2.Text = "C:\\Matt\\NWN2TK\\Data";
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(297, 9);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(132, 95);
            this.dataGridView1.TabIndex = 7;
            this.dataGridView1.Visible = false;
            // 
            // buttonShowSortableGrid
            // 
            this.buttonShowSortableGrid.Location = new System.Drawing.Point(12, 173);
            this.buttonShowSortableGrid.Name = "buttonShowSortableGrid";
            this.buttonShowSortableGrid.Size = new System.Drawing.Size(154, 23);
            this.buttonShowSortableGrid.TabIndex = 13;
            this.buttonShowSortableGrid.Text = "Show Sortable Grid";
            this.buttonShowSortableGrid.UseVisualStyleBackColor = true;
            this.buttonShowSortableGrid.Click += new System.EventHandler(this.buttonShowSortableGrid_Click);
            // 
            // buttonBuildIPRPSpells
            // 
            this.buttonBuildIPRPSpells.Location = new System.Drawing.Point(12, 64);
            this.buttonBuildIPRPSpells.Name = "buttonBuildIPRPSpells";
            this.buttonBuildIPRPSpells.Size = new System.Drawing.Size(154, 23);
            this.buttonBuildIPRPSpells.TabIndex = 12;
            this.buttonBuildIPRPSpells.Text = "Build IPRP Spells";
            this.buttonBuildIPRPSpells.UseVisualStyleBackColor = true;
            this.buttonBuildIPRPSpells.Click += new System.EventHandler(this.buttonBuildIPRPSpells_Click);
            // 
            // buttonGenerateMPFiles
            // 
            this.buttonGenerateMPFiles.Location = new System.Drawing.Point(12, 35);
            this.buttonGenerateMPFiles.Name = "buttonGenerateMPFiles";
            this.buttonGenerateMPFiles.Size = new System.Drawing.Size(154, 23);
            this.buttonGenerateMPFiles.TabIndex = 11;
            this.buttonGenerateMPFiles.Text = "Generate MP Files";
            this.buttonGenerateMPFiles.UseVisualStyleBackColor = true;
            this.buttonGenerateMPFiles.Click += new System.EventHandler(this.buttonGenerateMPFiles_Click);
            // 
            // progressBarStatus
            // 
            this.progressBarStatus.Location = new System.Drawing.Point(12, 262);
            this.progressBarStatus.Name = "progressBarStatus";
            this.progressBarStatus.Size = new System.Drawing.Size(414, 23);
            this.progressBarStatus.TabIndex = 14;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 128);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(65, 13);
            this.label1.TabIndex = 16;
            this.label1.Text = "2DA Name: ";
            // 
            // label2DAName
            // 
            this.label2DAName.Location = new System.Drawing.Point(83, 128);
            this.label2DAName.Name = "label2DAName";
            this.label2DAName.Size = new System.Drawing.Size(208, 23);
            this.label2DAName.TabIndex = 17;
            this.label2DAName.Text = "spells.2da";
            // 
            // buttonChoose2DA
            // 
            this.buttonChoose2DA.Location = new System.Drawing.Point(12, 144);
            this.buttonChoose2DA.Name = "buttonChoose2DA";
            this.buttonChoose2DA.Size = new System.Drawing.Size(75, 23);
            this.buttonChoose2DA.TabIndex = 18;
            this.buttonChoose2DA.Text = "Choose 2DA";
            this.buttonChoose2DA.UseVisualStyleBackColor = true;
            this.buttonChoose2DA.Click += new System.EventHandler(this.buttonChoose2DA_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "spells.2da";
            // 
            // buttonBlueprintDocumenter
            // 
            this.buttonBlueprintDocumenter.Location = new System.Drawing.Point(12, 202);
            this.buttonBlueprintDocumenter.Name = "buttonBlueprintDocumenter";
            this.buttonBlueprintDocumenter.Size = new System.Drawing.Size(154, 23);
            this.buttonBlueprintDocumenter.TabIndex = 19;
            this.buttonBlueprintDocumenter.Text = "Blueprint Documenter";
            this.buttonBlueprintDocumenter.UseVisualStyleBackColor = true;
            this.buttonBlueprintDocumenter.Click += new System.EventHandler(this.buttonBlueprintDocumenter_Click);
            // 
            // NWN2TK
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(441, 297);
            this.Controls.Add(this.buttonBlueprintDocumenter);
            this.Controls.Add(this.buttonChoose2DA);
            this.Controls.Add(this.label2DAName);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.progressBarStatus);
            this.Controls.Add(this.buttonShowSortableGrid);
            this.Controls.Add(this.buttonBuildIPRPSpells);
            this.Controls.Add(this.buttonGenerateMPFiles);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.labelDataPath1);
            this.Controls.Add(this.labelDataPath2);
            this.Name = "NWN2TK";
            this.Text = "NWN2 ToolKit by Kaedrin";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelDataPath1;
        private System.Windows.Forms.Label labelDataPath2;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button buttonShowSortableGrid;
        private System.Windows.Forms.Button buttonBuildIPRPSpells;
        private System.Windows.Forms.Button buttonGenerateMPFiles;
        private System.Windows.Forms.ProgressBar progressBarStatus;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2DAName;
        private System.Windows.Forms.Button buttonChoose2DA;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Button buttonBlueprintDocumenter;
    }
}

