<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin-inventory</title>
<script>
    function toggleEdit(id) {
        var row = document.getElementById('product' + id);
        var inputs = row.getElementsByTagName('input');
        for(var i = 0; i < inputs.length; i++) {
            inputs[i].readOnly = !inputs[i].readOnly;
        }
        var imgButton = document.getElementById('imgButton' + id);
        if (imgButton.style.display === "none") {
            imgButton.style.display = "block";
        } else {
            imgButton.style.display = "none";
            removeImageForms(id);
        }
    }

    function addProduct() {
        var form = document.createElement('form');
        form.setAttribute('action', 'addProduct');
        form.setAttribute('method', 'POST');

        var attributes = ['name', 'category', 'description', 'brand', 'stock', 'price'];
        for (var i = 0; i < attributes.length; i++) {
            var input = document.createElement('input');
            input.setAttribute('type', 'text');
            input.setAttribute('name', attributes[i]);
            form.appendChild(input);
        }

        var submit = document.createElement('input');
        submit.setAttribute('type', 'submit');
        submit.setAttribute('value', 'Save');
        form.appendChild(submit);

        document.body.appendChild(form);
    }

    function createImageForms(id) {
        if (!document.getElementById('imageForms' + id)) {
            var div = document.createElement('div');
            div.setAttribute('id', 'imageForms' + id);
            document.getElementById('product' + id).appendChild(div);

            var imageKeys = ["img_thumbnail", "img1", "img2", "img3"];
            var imageCount = 0;

            for (var i = 0; i < imageKeys.length; i++) {
                var imgElement = document.getElementById('img' + id + imageKeys[i]);
                var imgValue = imgElement ? imgElement.value : null;

                if (imgValue && imgValue !== "null" && imgValue.trim() !== "" && !imgValue.includes("null")) {
                    var form = document.createElement('form');
                    form.setAttribute('action', 'deleteImg');
                    form.setAttribute('method', 'POST');

                    var input1 = document.createElement('input');
                    input1.setAttribute('type', 'hidden');
                    input1.setAttribute('name', 'id');
                    input1.setAttribute('value', id);
                    form.appendChild(input1);

                    var input2 = document.createElement('input');
                    input2.setAttribute('type', 'hidden');
                    input2.setAttribute('name', 'imgKey');
                    input2.setAttribute('value', imageKeys[i]);
                    form.appendChild(input2);

                    var img = document.createElement('img');
                    img.setAttribute('src', imgValue);
                    img.setAttribute('alt', 'Image');
                    form.appendChild(img);

                    var button = document.createElement('button');
                    button.setAttribute('type', 'submit');
                    button.innerHTML = 'Delete';
                    form.appendChild(button);

                    div.appendChild(form);
                    imageCount++;
                }
            }

            if (imageCount < 4) {
                addImageForm(id);
            } else {
                var p = document.createElement('p');
                p.innerHTML = 'Max images reached, remove an image for replacing';
                div.appendChild(p);
            }
        }
    }

    function removeImageForms(id) {
        var div = document.getElementById('imageForms' + id);
        if (div) {
            div.parentNode.removeChild(div);
        }
    }

    function addImageForm(id) {
        if (document.getElementById('uploadForm' + id)) {
            return;
        }
        var form = document.createElement('form');
        form.setAttribute('id', 'uploadForm' + id);
        form.setAttribute('action', 'uploadProdImg');
        form.setAttribute('method', 'POST');
        form.setAttribute('enctype', 'multipart/form-data');

        var input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('name', 'image');
        form.appendChild(input);

        var submit = document.createElement('input');
        submit.setAttribute('type', 'submit');
        submit.setAttribute('value', 'Upload Image');
        form.appendChild(submit);

        var inputId = document.createElement('input');
        inputId.setAttribute('type', 'hidden');
        inputId.setAttribute('name', 'productId');
        inputId.setAttribute('value', id);
        form.appendChild(inputId);

        document.getElementById('imageForms' + id).appendChild(form);
    }
</script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/inventory.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/stylesheets/seller-header.css">
</head>
<body>
<header>
    <nav>
        <a href="inventory">Inventory</a>
        <a href="orders">Orders</a>
        <a href="sales">Sales</a>
        <a href="logout">Logout</a>
    </nav>
</header>
<section class="inventory-header">
    <button onclick="addProduct()">Add new product</button>
    <form action="commit" method="POST">
        <button type="submit">Save All Changes</button>
    </form>
</section>
<section class="inventory-body">
    <table>
        <tr>
            <th>Item-Name</th>
            <th>Flavor</th>
            <th>Description</th>
            <th>Brand</th>
            <th>Stock</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        <%
            @SuppressWarnings("unchecked")
            ArrayList<HashMap<String, String>> productList = (ArrayList<HashMap<String, String>>) request.getSession().getAttribute("productList");
            for (HashMap<String, String> product : productList) {
                String[] imageKeys = {"img_thumbnail", "img1", "img2", "img3"};
        %>
        <tr id="product<%= product.get("id") %>">
            <form id="<%= product.get("id") %>" action="updateInventory" method="POST">
                <input type="hidden" name="id" value="<%= product.get("id") %>">
                <td><input type="text" name="name" value="<%= product.get("name") %>" readonly></td>
                <td><input type="text" name="category" value="<%= product.get("category") %>" readonly></td>
                <td><input type="text" name="description" value="<%= product.get("description") %>" readonly></td>
                <td><input type="text" name="brand" value="<%= product.get("brand") %>" readonly></td>
                <td><input type="number" name="stock" value="<%= product.get("stock") %>" readonly></td>
                <td><input type="number" name="price" value="<%= product.get("price") %>" readonly></td>
                <td>
                    <button type="button" onclick="toggleEdit('<%= product.get("id") %>')">Edit</button>
                    <button type="submit">Save</button>
                    <button type="submit" formaction="deleteProduct">Delete</button>
                    <button id="imgButton<%= product.get("id") %>" style="display:none;" type="button" onclick="createImageForms('<%= product.get("id") %>')">Add/Delete Images</button>
                </td>
            </form>
            <% for (String key : imageKeys) { %>
                <% if (product.get(key) != null && !product.get(key).equals("null")) { %>
                    <input type="hidden" id="img<%= product.get("id") + key %>" value="<%= product.get(key) %>">
                <% } %>
            <% } %>
        </tr>
        <%
            }
        %>
    </table>
</section>
</body>
</html>
