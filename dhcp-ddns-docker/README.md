# Examen DHCP — Laboratorio Kea + DNS

Versión pulida del README, lista para publicar en GitHub y para usar como base en una publicación en LinkedIn.

## Resumen

Este repositorio muestra un laboratorio reproducible para servicios de red: servidor DHCPv4 con Kea, servidor DNS con soporte DDNS y contenedores auxiliares (router y cliente de prueba). Es ideal para demostrar conocimientos prácticos sobre DHCP, DDNS y despliegue con contenedores.

## Características clave

- Configuración de Kea DHCPv4 con subredes, pools y reservas (archivo: `mortadelo/dhcp4.jsonc`).
- Integración con servidor DNS para actualizaciones dinámicas (DDNS).
- Contenedores separados para Kea, DNS, router y cliente, con ejemplos de Dockerfile y entrypoints.
- Scripts y archivos de zona para comprobar la integración DDNS.

## Estructura del repositorio

- `compose.yml` — orquestación para levantar el laboratorio con Docker Compose.
- `docker/` — Dockerfiles y entrypoints por servicio:
  - `cliente/` — contenedor cliente para generar peticiones DHCP.
  - `dnsserver/` — servidor DNS (BIND u otra implementación) configurado para DDNS.
  - `kea/` — imagen Kea con ejemplos de configuración (`kea-dhcp4.conf.json`).
  - `router/` — contenedor que simula la puerta de enlace.
- `filemon/` — configuración de BIND y archivos de zona (`zonas/`).
- `mortadelo/` — configuraciones concretas del ejercicio (principalmente `dhcp4.jsonc` y `dhcp-ddns.jsonc`).

## Quickstart — levantar el laboratorio

1) Construir y levantar los servicios:

```bash
docker compose -f compose.yml up --build -d
```

2) Ver logs para validar arranque:

```bash
docker compose -f compose.yml logs -f kea
docker compose -f compose.yml logs -f dnsserver
```

3) Probar DHCP desde el contenedor cliente:

```bash
docker compose -f compose.yml exec cliente bash
# dentro del contenedor
dhclient -v -1 eth0 || sudo dhclient -v -1 eth0
```

## Validación de configuración

- `dhcp4.jsonc` está en formato JSONC (puede contener comentarios). Para validarlo con `jq` elimine los comentarios antes:

```bash
sed '/^\s*\/\//d' mortadelo/dhcp4.jsonc | jq .
```

- Comprobar que Kea ha cargado la configuración (según la imagen usada):

```bash
docker compose -f compose.yml exec kea keactrl -c /etc/kea/kea-dhcp4.conf status
# o inspeccionar el log configurado, por ejemplo /var/log/kea/david.log
```

