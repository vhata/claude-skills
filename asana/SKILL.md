---
name: asana
description: >
  Interact with Asana tasks via the REST API. Use when the user asks about their
  Asana tasks, wants to list/view/create/update tasks, or references Asana tickets.
  Triggers on mentions of Asana, tickets, task lists, or sprint boards.
version: 1.0.0
---

# Asana Integration

Query and manage Asana tasks using the REST API with a personal access token.

## Authentication

Read the token from `~/.asana-token`:

```bash
ASANA_TOKEN=$(cat ~/.asana-token)
```

If the file doesn't exist, ask the user to provide their PAT and save it:

```bash
echo -n "TOKEN_HERE" > ~/.asana-token && chmod 600 ~/.asana-token
```

## User Info

- Workspace GID: `236888843494340` (Discord)
- User: `me` (resolves to the token owner)

## Common API Calls

All requests use:

```bash
curl -s -H "Authorization: Bearer $ASANA_TOKEN" "https://app.asana.com/api/1.0/..."
```

### List open tasks assigned to me

```bash
curl -s -H "Authorization: Bearer $ASANA_TOKEN" \
  "https://app.asana.com/api/1.0/tasks?assignee=me&workspace=236888843494340&opt_fields=name,completed,due_on,projects.name&completed_since=now&limit=50"
```

### Get task details

```bash
curl -s -H "Authorization: Bearer $ASANA_TOKEN" \
  "https://app.asana.com/api/1.0/tasks/TASK_GID?opt_fields=name,notes,due_on,completed,projects.name,tags.name,custom_fields.name,custom_fields.display_value"
```

### Get task stories (comments/activity)

```bash
curl -s -H "Authorization: Bearer $ASANA_TOKEN" \
  "https://app.asana.com/api/1.0/tasks/TASK_GID/stories?opt_fields=text,created_by.name,created_at,type&limit=20"
```

### Search tasks

```bash
curl -s -H "Authorization: Bearer $ASANA_TOKEN" \
  "https://app.asana.com/api/1.0/workspaces/236888843494340/tasks/search?text=QUERY&assignee.any=me&opt_fields=name,completed,due_on,projects.name&is_subtask=false"
```

### Add a comment to a task

```bash
curl -s -X POST -H "Authorization: Bearer $ASANA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"data":{"text":"Comment text here"}}' \
  "https://app.asana.com/api/1.0/tasks/TASK_GID/stories"
```

### Complete a task

```bash
curl -s -X PUT -H "Authorization: Bearer $ASANA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"data":{"completed":true}}' \
  "https://app.asana.com/api/1.0/tasks/TASK_GID"
```

## Behavior

- Default action (no args): list open tasks assigned to me
- If given a task GID or name fragment: fetch details for that task
- Always pipe JSON through `python3 -m json.tool` for readability
- Present tasks in a table format when listing multiple
- Flag overdue tasks by comparing `due_on` to today's date
