# Development

In `template_server`:

```bash
docker compose up --build --detach
dart bin/main.dart --apply-migrations
serverpod generate --watch
```

After creating a new model:

```bash
serverpod create-migration
dart bin/main.dart --role maintenance --apply-migrations
```

In `template_client`:

```bash
dart run build_runner watch --delete-conflicting-outputs
```