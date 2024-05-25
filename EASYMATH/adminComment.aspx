<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminComment.aspx.cs" Inherits="wappAssWebLearning.EASYMATH.adminComment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard</title>
    <link href="../CSS/adminComment.css" rel="stylesheet" />
    <script src="../js/adminComment.js"></script>
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
                <h2>Existing Comment</h2>
                <asp:UpdatePanel ID="updateComments" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="commentTable" runat="server" AutoGenerateColumns="False" CssClass="table" 
                            OnRowCommand="commentTable_RowCommand" OnRowEditing="commentTable_RowEditing" OnRowUpdating="commentTable_RowUpdating"
                            OnRowCancelingEdit="commentTable_RowCancelingEdit" OnRowDeleting="commentTable_RowDeleting"
                            DataKeyNames="commentNo">
                            <Columns>
                                <asp:BoundField DataField="commentNo" HeaderText="comment No" ReadOnly="True" ItemStyle-Width="10%" />                                
                                <asp:TemplateField HeaderText="Comment Description" ItemStyle-Width="25%">
                                    <ItemTemplate>
                                        <%# Eval("commentDescription") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="commentDescription" runat="server" Text='<%# Bind("commentDescription") %>' />
                                        <asp:RequiredFieldValidator ID="rfvForumTitle" runat="server" ControlToValidate="commentDescription" ErrorMessage="Comment is required." Display="Dynamic" ForeColor="Red" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comment Image" ItemStyle-Width="25%">
                                    <ItemTemplate>
                                        <asp:Label ID="commentImage" runat="server" Text='<%# Eval("commentImage") %>'/>                                            
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:HiddenField ID="hiddenFieldForOriginalCommentImage" runat="server" Value='<%# Eval("commentImage") %>' />
                                        <input type="file" id="commentImageUpload" onchange="uploadFile(this);" />
                                        <asp:HiddenField ID="hiddenFileName" runat="server" /> 
                                        <asp:HiddenField ID="hiddenCommentImage" runat="server" />
                                    </EditItemTemplate>                                      

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comment Date" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <%# Eval("commentDate") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="commentDate" runat="server" Text='<%# Bind("commentDate") %>'/>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Forum No" ItemStyle-Width="15%">
                                    <ItemTemplate>
                                        <%# Eval("forumNo") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="forumNo" runat="server" Text='<%# Bind("forumNo") %>' />
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
                                        <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="aspButton" CommandName="Remove" CommandArgument='<%# Container.DataItemIndex %>' OnClientClick="return confirm('Are you sure you want to delete this record?');" />
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
