<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminForum.aspx.cs" Inherits="wappAssWebLearning.EASYMATH.adminForum" EnableEventValidation="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard</title>
    <link href="../CSS/adminForum.css" rel="stylesheet" />
    <script src="../js/adminForum.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <header>
            <img src="../IMAGES/easyMathLogo.png" alt="Easy Math Logo" class="logo" />
            <h1 style="color: black;">Admin Dashboard</h1>
        </header>
        <nav class="menu">
            <ul>
                <li><a href="home.aspx">Home</a></li>
                <li><a href="adminForum.aspx">Forum</a></li>
                <li><a href="adminComment.aspx">Comment</a></li>
                <li><a href="assignment.aspx">Assignment</a></li>
                <li><a href="quiz.aspx">Quiz</a></li>
                <li><a href="profile.aspx">Profile</a></li>
            </ul>
        </nav>
        <section>
            <div class="container">
                    <h2>Existing Forum </h2>
                    <div>
                        <asp:Label ID="errMsg" runat="server" Visible="true"></asp:Label>
                    </div>
                    <asp:UpdatePanel ID="updateForums" runat="server">
                        <ContentTemplate>
                            <div>
                                <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
                            </div>
                            <asp:GridView ID="forumTable" runat="server" AutoGenerateColumns="False" CssClass="table" 
                                OnRowCommand="forumTable_RowCommand" OnRowEditing="forumTable_RowEditing" OnRowUpdating="forumTable_RowUpdating"
                                OnRowCancelingEdit="forumTable_RowCancelingEdit" OnRowDeleting="forumTable_RowDeleting"
                                DataKeyNames="forumNo">
                                <Columns>
                                    <asp:BoundField DataField="forumNo" HeaderText="Forum No" ReadOnly="True" ItemStyle-Width="10%" />
                                    <asp:TemplateField HeaderText="Forum Title" ItemStyle-Width="30%">
                                        <ItemTemplate>
                                            <%# Eval("forumTitle") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="forumTitle" runat="server" Text='<%# Bind("forumTitle") %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Forum Description" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <%# Eval("forumDescription") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="forumDescription" runat="server" Text='<%# Bind("forumDescription") %>' />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Forum Image" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <asp:Label ID="forumImage" runat="server" Text='<%# Eval("forumImage") %>'/>                                            
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="hiddenFieldForOriginalForumImage" runat="server" Value='<%# Eval("forumImage") %>' />
                                            <input type="file" id="forumImageUpload"  onchange="uploadFile(this);" />
                                            <asp:HiddenField ID="hiddenFileName" runat="server" /> 
                                            <asp:HiddenField ID="hiddenForumImage" runat="server" />                                            
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Forum Date" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <%# Eval("forumDate") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="forumDate" runat="server" Text='<%# Bind("forumDate") %>'/>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Username" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <%# Eval("userName") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="userName" runat="server" Text='<%# Bind("userName") %>'/>
                                        </EditItemTemplate>
                                    </asp:TemplateField>                                    
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="editButton" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>'  />
                                            <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="Remove" CssClass="aspButton" CommandArgument='<%# Container.DataItemIndex %>' OnClientClick="return confirm('Are you sure you want to delete this record?');"  />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="editButton" CommandName="Update" />
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="editButton" CommandName="Cancel" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="hiddenButton" runat="server" Style="display: none;" OnClick="hiddenButton_Click" />                    
                </div>
            </section>
        <footer>
            <p>&copy; 2024 Easy Math. All rights reserved.</p>
        </footer>
    </form>
</body>
</html>
