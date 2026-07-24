<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gimnasio FitCIMM - Panel Principal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --fc-navy: #10233e;
                --fc-navy-2: #17335a;
                --fc-orange: #ff7a1a;
                --fc-orange-2: #ff9b4d;
                --fc-mint: #0fbf8f;
                --fc-blue: #2f6fed;
                --fc-purple: #7c5cff;
                --fc-bg: #f4f6fa;
                --fc-text: #2a3242;
                --fc-muted: #6b7488;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: var(--fc-bg);
                color: var(--fc-text);
            }

            h1, h2, h3, h4, h5, .navbar-brand {
                font-family: 'Poppins', sans-serif;
            }

            /* NAVBAR */
            .navbar {
                background: var(--fc-navy) !important;
                padding-top: .85rem;
                padding-bottom: .85rem;
            }
            .navbar-brand {
                font-weight: 800;
                letter-spacing: .3px;
                display: flex;
                align-items: center;
                gap: .5rem;
            }
            .navbar-brand .bi {
                color: var(--fc-orange);
                font-size: 1.4rem;
            }
            .navbar-nav .nav-link {
                font-weight: 500;
                color: rgba(255,255,255,.75) !important;
                margin: 0 .15rem;
                border-radius: 8px;
                padding: .5rem .9rem !important;
                transition: all .2s ease;
            }
            .navbar-nav .nav-link:hover {
                color: #fff !important;
                background: rgba(255,255,255,.08);
            }
            .navbar-nav .nav-link.active {
                color: #fff !important;
                background: var(--fc-orange);
            }

            /* HERO */
            .hero {
                position: relative;
                overflow: hidden;
                background: linear-gradient(120deg, var(--fc-navy) 0%, var(--fc-navy-2) 55%, #1d4f8c 100%);
                padding: 4.5rem 0 5rem;
            }
            .hero::before {
                content: "";
                position: absolute;
                top: -60px;
                right: -60px;
                width: 320px;
                height: 320px;
                background: radial-gradient(circle, rgba(255,122,26,.35) 0%, rgba(255,122,26,0) 70%);
                border-radius: 50%;
            }
            .hero::after {
                content: "";
                position: absolute;
                bottom: -100px;
                left: -80px;
                width: 260px;
                height: 260px;
                background: radial-gradient(circle, rgba(15,191,143,.25) 0%, rgba(15,191,143,0) 70%);
                border-radius: 50%;
            }
            .hero .badge-pill {
                background: rgba(255,255,255,.12);
                color: #fff;
                border: 1px solid rgba(255,255,255,.25);
                padding: .4rem 1rem;
                border-radius: 30px;
                font-size: .8rem;
                font-weight: 500;
                letter-spacing: .5px;
            }
            .hero h1 {
                font-weight: 800;
                margin-top: 1rem;
            }
            .hero p.lead {
                color: rgba(255,255,255,.8);
                max-width: 640px;
                margin-inline: auto;
            }

            /* CARDS */
            .module-card {
                border: none;
                border-radius: 18px;
                background: #fff;
                box-shadow: 0 4px 18px rgba(16, 35, 62, .06);
                transition: transform .25s ease, box-shadow .25s ease;
                overflow: hidden;
            }
            .module-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 16px 30px rgba(16, 35, 62, .14);
            }
            .module-card .card-body {
                padding: 2rem 1.6rem;
            }
            .icon-wrap {
                width: 62px;
                height: 62px;
                border-radius: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.6rem;
                margin: 0 auto 1.1rem;
                transition: transform .25s ease;
            }
            .module-card:hover .icon-wrap {
                transform: scale(1.08) rotate(-4deg);
            }
            .icon-mint  { background: rgba(15,191,143,.12); color: var(--fc-mint); }
            .icon-blue  { background: rgba(47,111,237,.12); color: var(--fc-blue); }
            .icon-orange{ background: rgba(255,122,26,.12); color: var(--fc-orange); }
            .icon-purple{ background: rgba(124,92,255,.12); color: var(--fc-purple); }

            .module-card .card-title {
                font-weight: 700;
                font-size: 1.08rem;
            }
            .module-card .card-text {
                color: var(--fc-muted);
                font-size: .9rem;
                min-height: 65px;
            }

            .btn-module {
                border-radius: 10px;
                font-weight: 600;
                padding: .6rem 1rem;
                border: none;
                color: #fff;
                transition: opacity .2s ease;
            }
            .btn-module:hover { opacity: .88; color: #fff; }
            .btn-mint   { background: var(--fc-mint); }
            .btn-blue   { background: var(--fc-blue); }
            .btn-orange { background: var(--fc-orange); }
            .btn-purple { background: var(--fc-purple); }

            .section-label {
                text-transform: uppercase;
                font-size: .78rem;
                font-weight: 700;
                letter-spacing: 1.2px;
                color: var(--fc-muted);
            }

            footer {
                background: var(--fc-navy) !important;
            }
            footer small { color: rgba(255,255,255,.6); }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">
                    <i class="bi bi-lightning-charge-fill"></i> FitCIMM Paipa
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="IngresoServlet">Control de Acceso</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="SocioServlet?accion=listar">Socios</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MembresiaServlet?accion=listar">Membresías</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="PlanServlet?accion=listar">Planes</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="hero text-center text-white">
            <div class="container position-relative">
                <span class="badge-pill">SENA · ADSO · CIMM Boyacá</span>
                <h1 class="display-5">Sistema de Gestión de Gimnasio</h1>
                <p class="lead mt-3">Sede Paipa, Boyacá — Control de Socios, Membresías e Ingresos</p>
            </div>
        </div>

        <div class="container mb-5" style="margin-top: -3.2rem;">
            <div class="row g-4">

                <div class="col-md-6 col-lg-3">
                    <div class="card module-card h-100">
                        <div class="card-body text-center">
                            <div class="icon-wrap icon-mint">
                                <i class="bi bi-door-open-fill"></i>
                            </div>
                            <h5 class="card-title">Control de Acceso</h5>
                            <p class="card-text">Valida el ingreso diario de socios por número de documento.</p>
                            <a href="IngresoServlet" class="btn btn-module btn-mint w-100">Ir a Recepción</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="card module-card h-100">
                        <div class="card-body text-center">
                            <div class="icon-wrap icon-blue">
                                <i class="bi bi-people-fill"></i>
                            </div>
                            <h5 class="card-title">Gestión de Socios</h5>
                            <p class="card-text">Registro de nuevos clientes, edición y búsqueda con reglas de documento y edad.</p>
                            <a href="SocioServlet?accion=listar" class="btn btn-module btn-blue w-100">Ver Socios</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="card module-card h-100">
                        <div class="card-body text-center">
                            <div class="icon-wrap icon-orange">
                                <i class="bi bi-credit-card-fill"></i>
                            </div>
                            <h5 class="card-title">Venta de Membresías</h5>
                            <p class="card-text">Asignación de planes, cálculo automático de vencimientos y estados.</p>
                            <a href="MembresiaServlet?accion=listar" class="btn btn-module btn-orange w-100">Ver Membresías</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3">
                    <div class="card module-card h-100">
                        <div class="card-body text-center">
                            <div class="icon-wrap icon-purple">
                                <i class="bi bi-clipboard2-data-fill"></i>
                            </div>
                            <h5 class="card-title">Catálogo de Planes</h5>
                            <p class="card-text">Administración de tarifarios (Día, Mensual, Trimestral) con reglas de duraciones.</p>
                            <a href="PlanServlet?accion=listar" class="btn btn-module btn-purple w-100">Ver Planes</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <footer class="text-white text-center py-3 mt-auto">
            <div class="container">
                <small>SENA CIMM Boyacá — Tecnólogo en Análisis y Desarrollo de Software (ADSO)</small>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
