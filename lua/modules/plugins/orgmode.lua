return {
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    dependencies = {
      {
        'akinsho/org-bullets.nvim',
        event = { 'BufRead *.org', 'BufNewFile *.org' },
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require('org-bullets').setup {}
        end,
      },
    },
    ft = { 'org' },
    config = function()
      require('orgmode').setup {
        org_agenda_files = '~/personal/notes/org/*',
        org_default_notes_file = '~/personal/notes/org/refile.org',
        org_todo_keywords = {
          'TODO(t)',
          'PLANNING(p)',
          'IN-PROGRESS(i@/!)',
          'VERIFYING(v!)',
          'BLOCKED(b@)',
          '|',
          'DONE(d!)',
          'OBE(o@!)',
          'WONT-DO(w@/!)',
        },
        org_todo_keyword_faces = {
          TODO = ':foreground #DAA520 :weight bold',
          PLANNING = ':foreground #FF1493 :weight bold',
          ['IN-PROGRESS'] = ':foreground #00FFFF :weight bold',
          VERIFYING = ':foreground #FF8C00 :weight bold',
          BLOCKED = ':foreground #FF0000 :weight bold',
          DONE = ':foreground #32CD32 :weight bold',
          OBE = ':foreground #32CD32 :weight bold',
          ['WONT-DO'] = ':foreground #32CD32 :weight bold',
        },
        org_capture_templates = {
          t = {
            description = 'General To-Do',
            template = '* TODO [#B] %?\n:Created: %U\n',
            headline = 'General Tasks',
            target = '~/personal/notes/org/todos.org',
          },
          m = {
            description = 'Maybe Do',
            template = '* %?\n:Created: %U\n',
            headline = 'Maybe Do',
            target = '~/personal/notes/org/maybe.org',
          },
          w = {
            description = 'Work Log',
            template = '* %?',
            target = '~/personal/notes/org/work.org',
            datetree = {
              tree_type = 'day',
            },
          },
          W = {
            description = 'Work To-Do',
            template = '* TODO [#B] %? :trabalho:umanni:\n:Created: %U\n',
            headline = 'Working',
            target = '~/personal/notes/org/work-todo.org',
          },
          d = {
            description = 'Dump Log',
            template = '** %^{Title}\n :Created: %U\n [[%^{Link}]]\n',
            target = '~/personal/notes/org/dump.org',
            headline = 'Dump Log',
          },
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
