<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@include file="/WEB-INF/views/template/header.jsp"%>
<style>@import url(https://fonts.googleapis.com/css?family=Roboto:400,300,500,700);

body {
    font-family:'Roboto', Helvetica, Arial, sans-serif;
    font-weight:300;
    background:#333;
}
h3 {
    font-size: 1.3em;
    margin:0;
}
p{
    font-size:0.9em;
}

/* Hover Card
.......................................................................*/
div.catCard {
    border: solid 5px #e9e9e9;
    background: #d8d8d8;
    width: 221px;
    height: 400px;
    display: block;
    position: relative;
    overflow: hidden;
}
div.lowerCatCard {
    position: absolute;
    background: #e9e9e9;
    padding: 5px 5px;
    height: 200px;
    -webkit-transition: all 0.6s ease;
    -moz-transition:    all 0.6s ease;
    -o-transition:      all 0.6s ease;
    transition:         all 0.6s ease;
}
div.lowerCatCard:hover {
    opacity: 0.95;
    bottom: 0;
    height: 390px;
}
div.catCard  div.lowerCatCard {
    left: 0;
    bottom: -3%;
    width: 215px;
}
div.catCard:hover div.lowerCatCard {
    bottom: 0;
}
li.catCardList {
    width:225px;
    display: inline-block;
    margin-right: 19px;
    margin-top: 25px;
}
li.catCardList-last {
    margin-right: 0;
    width:225px;
    display: inline-block;
}
ul.catCardList {
    margin: 0;
}
#catCardButton {
    position: absolute;
    width: 190px;
    bottom: 5px;
    -webkit-transition: all 0.6s ease;
    -moz-transition:    all 0.6s ease;
    -o-transition:      all 0.6s ease;
}
div.lowerCatCard:hover #catCardButton {
    bottom: 5px;
}
.startingPrice span {
    font-size: 16px;
    color: #c90c12;
    font-weight: 300;
}
div.startingPrice {
    margin-bottom: 5px;
    color: #000;
    font-weight: 300;
}
.catCard img {
    border: 1px solid #dddddd;
    width: 219px;
    height: 198px;
}
.catCard img:hover {
    border: 1px solid #bababa;
}

/* Button
.......................................................................*/
.button {
    cursor: pointer;
    font-size: 14px !important;
    color: #ffffff;
    padding: 7px 10px !important;
    text-decoration: none !important;
    text-transform: uppercase !important;
    letter-spacing: 0 !important;
    background: #000;
    border: none;
    border-bottom: solid 1px #c90c12;
    text-align: center;
    margin-top: 10px;
}
.button:hover {
    background-color: #c90c12;
    border: none;
    border-bottom: solid 1px #000;
    box-shadow: 0 2px 3px #a8a8a8;
    transform: scale(1.04);
    -webkit-transform: scale(1.04);
    -moz-transform: scale(1.04);
    -o-transform: scale(1.04);
    -ms-transform: scale(1.04);
}
.button:active {
    background: #000;
}
.button a {
    color: #ffffff;
    padding: 7px 30px !important;
    text-decoration: none;
}
.button a:hover {
    color: #ffffff;
}
.button:hover {
    color: #fff;
}</style>
<ul class="catCardList">


    <c:forEach items="${products}" var="product">
        <li class="catCardList">
            <div class="catCard"><a href="#"><img src="http://placehold.it/221x200" alt=""></a>
                <div class="lowerCatCard">
                    <h3>${product.productName}</h3>
                    <div class="startingPrice">Prices Starting At <span>${product.productPrice}</span></div>
                    <p>${product.productDescription}</p>
                    <h4>AVAILABILITY : ${product.productStatus}</h4>
                    <ul>

                    </ul>
                    <div id="catCardButton" class="button"><a href="<spring:url value="/productList/viewproduct/${product.productId}" />">View Product</a></div>

                </div>
            </div>
        </li>
    </c:forEach>
</ul>
<%@include file="/WEB-INF/views/template/footer.jsp"%>