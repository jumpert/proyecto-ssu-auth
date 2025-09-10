<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8"/>
  <title>${msg("loginTitle")!"Inicio de sesión"}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <link rel="stylesheet" href="${url.resourcesPath}/css/ssu.css"/>
</head>
<body class="ssu-body">
  <div class="ssu-card">
    <div class="ssu-header">
      <img class="ssu-logo" src="${url.resourcesPath}/img/labanca-logo.svg" alt="LaBanca"/>
      <h1 class="ssu-title">SSU</h1>
      <h2 class="ssu-subtitle">Inicio de sesión</h2>
    </div>

    <#if message?has_content>
      <div class="ssu-alert">${message.summary?no_esc}</div>
    </#if>

    <form id="kc-form-login" class="ssu-form" action="${url.loginAction}" method="post"
          onsubmit="login.disabled = true; return true;">
      <input type="hidden" id="id-hidden-input" name="credentialId"
             <#if auth.selectedCredential??>value="${auth.selectedCredential}"</#if> />

      <label for="username">${msg("Usuario o email")!"Usuario o email"}</label>
      <input id="username" name="username" type="text" value="${(login.username!'')}" autofocus/>

      <label for="password">${msg("Contraseña")!"Contraseña"}</label>
      <input id="password" name="password" type="password"/>

      <#if realm.rememberMe>
        <div class="ssu-remember-me">
          <input type="checkbox" id="rememberMe" name="rememberMe"
                <#if login.rememberMe?? && login.rememberMe?string == "on">checked</#if> />
          <label for="rememberMe">${msg("Recordarme")!"Recordarme"}</label>
        </div>
      </#if>
      <button name="login" id="kc-login" type="submit">${msg("Iniciar sesión")!"Iniciar sesión"}</button>
    </form>

    <#if realm.resetPasswordAllowed>
      <a class="ssu-hint" href="${url.loginResetCredentialsUrl}">
        ${msg("¿Olvidaste tu contraseña?")!"¿Olvidaste tu contraseña?"}
      </a>
    </#if>

    <#if realm.registrationAllowed>
      <a class="ssu-hint" href="${url.loginAction}?registration">
        ${msg("¿No tienes cuenta? Regístrate")!"¿No tienes cuenta? Regístrate"}
      </a>
    </#if>

  </div>
</body>
</html>
