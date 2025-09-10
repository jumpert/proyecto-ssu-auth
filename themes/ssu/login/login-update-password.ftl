<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8"/>
  <title>Definir nueva contraseña</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="stylesheet" href="${url.resourcesPath}/css/ssu.css"/>
</head>
<body class="ssu-body">
  <div class="ssu-card">
    <div class="ssu-header">
      <img class="ssu-logo" src="${url.resourcesPath}/img/labanca-logo.svg" alt="LaBanca"/>
      <h2>Definir nueva contraseña</h2>
    </div>

    <#if message?has_content>
      <div class="ssu-alert">${message.summary?no_esc}</div>
    </#if>

    <form id="kc-passwd-update-form" class="ssu-form" action="${url.loginAction}" method="post">
      <label for="password-new">${msg("Nueva contraseña")!"Nueva contraseña"}</label>
      <input id="password-new" name="password-new" type="password" autocomplete="new-password"/>

      <label for="password-confirm">${msg("Confirmar contraseña")!"Confirmar contraseña"}</label>
      <input id="password-confirm" name="password-confirm" type="password" autocomplete="new-password"/>

      <button id="kc-login" type="submit">${msg("Guardar")!"Guardar"}</button>
    </form>
  </div>
</body>
</html>
