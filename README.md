# Healthy Habits Tracker

A full-stack React and Express wellness tracker with authentication, habit
tracking, scheduling, progress charts, wellness articles, and a dashboard.

## Run locally

```bash
npm install
npm run dev
```

The app runs on port `5000`.

## Production build

```bash
npm run build
npm run start
```

The server needs these environment variables:

- `DATABASE_URL` — PostgreSQL connection string
- `SESSION_SECRET` — a long random session secret
- `REPL_ID` — required for the included Replit Auth setup
- `ISSUER_URL` — optional; defaults to `https://replit.com/oidc`

Run `npm run db:push` after configuring `DATABASE_URL` to create/update the
database schema.

## GitHub

1. Create a new GitHub repository.
2. Extract this ZIP and upload the project files, or push them with Git.
3. Do not upload `node_modules`, `dist`, or any `.env` file.
4. Add the environment variables in the service where you deploy the app.

## Cloudflare compatibility

This project is GitHub-ready, but it is **not a Cloudflare Pages-only app** in
its current form. The frontend is built with Vite, while authentication,
sessions, API routes, and PostgreSQL access run in the Express server.

For the complete app, deploy the Node/Express server on a Node-compatible host
and use Cloudflare as the DNS, proxy, or custom-domain layer.

If you deploy only the Vite output to Cloudflare Pages:

- Build command: `npm run build`
- Output directory: `dist/public`

Only the static frontend will be available. Login, session persistence, and
server-backed features will not work because Cloudflare Pages will not run the
included Express server or PostgreSQL connection.

To run the complete application directly on Cloudflare, the server would need
to be migrated to Cloudflare Workers, with authentication and database access
rewritten for Cloudflare-compatible services.

## License

MIT