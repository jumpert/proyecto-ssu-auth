<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8"/>
  <title>Restablecer contraseña</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="stylesheet" href="${url.resourcesPath}/css/ssu.css"/>
</head>
<body class="ssu-body">
  <div class="ssu-card">
    <div class="ssu-header">
      <img class="ssu-logo" src="${url.resourcesPath}/img/labanca-logo.svg" alt="LaBanca"/>
      <h2>Restablecer contraseña</h2>
    </div>

    <#if message?has_content>
      <div class="ssu-alert">${message.summary?no_esc}</div>
    </#if>

    <form id="kc-reset-password-form" class="ssu-form" action="${url.loginAction}" method="post">
      <label for="username">${msg("Usuario o correo")!"Usuario o correo"}</label>
      <input id="username" name="username" type="text" value="${(login.username!'')}" autofocus/>
      <button id="kc-login" type="submit">${msg("Continuar")!"Continuar"}</button>
    </form>

    <a class="ssu-hint" href="${url.loginUrl}">${msg("Volver al inicio")!"Volver al inicio"}</a>
  </div>
</body>
</html>
