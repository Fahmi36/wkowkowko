<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pelayanan Jakarta</title>

    <link rel="stylesheet" href="{{ url('css/bootstrap.css') }}" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <link href="{{ url('vendors/mdi/css/materialdesignicons.css') }}" media="all" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="{{ url('css/stylesheet.css') }}" type="text/css">
</head>
<body class="bg-light">

<div class="container go-register">
    <!-- Company -->
    <div class="form__container form__container-login">
        @include('pages.company')
    </div>
    <!-- Company End -->

    <!-- Invest Form Starts -->
    @include('pages.investasi')
    <!-- Invest Form Ends -->
</div>

<!--JS-->
<script src="{{ url('js/jquery-3.3.1.slim.min.js') }}"></script>
<script src="{{ url('js/popper.min.js') }}"></script>
<script src="{{ url('js/bootstrap.js') }}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8.15.3/dist/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
<script src="{{ url('js/guest.js') }}"></script>
</body>
</html>