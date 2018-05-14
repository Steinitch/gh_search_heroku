require 'rails_helper'

RSpec.feature 'Searches', type: :feature do

  scenario 'Search returns results' do
    mock_omniauth
    visit root_path
    expect(page).to have_text 'GitHub Search for Teladoc'
    expect(page).to have_link('Log In', href: github_auth_path)
    click_link 'Log In'
    expect(page).to have_text 'Enter a term below to search repositories on GitHub'
    fill_in 'query', with: 'rails'
    click_button 'submit_btn'
    allow_any_instance_of(HttpRequest).to receive(:search_github).and_return(mock_response)
    expect(page).to have_text 'oh-my-zsh'
    click_link 'Logout'
    expect(page).to have_text 'You must login to continue to the search'
    # session is now null, shouldn't access Search page
    click_link 'Search'
    expect(page).to have_text 'You must login to continue to the search'
  end

  def mock_omniauth
    OmniAuth.config.test_mode = true
    omniauth_hash             = { 'provider' => 'github', 'uid' => '9905647', 'info' => { 'nickname' => 'Steinitch', 'email' => 'paulstettnisch@gmail.com', 'name' => 'Paul Stettnisch', 'image' => 'https://avatars0.githubusercontent.com/u/9905647?v=4', 'urls' => { 'GitHub' => 'https://github.com/Steinitch', 'Blog' => '' } }, 'credentials' => { 'token' => 'b514c94d1f11bd8f689a49b4d8010be925ee39bd', 'expires' => false }, 'extra' => { 'raw_info' => { 'login' => 'Steinitch', 'id' => 9905647, 'avatar_url' => 'https://avatars0.githubusercontent.com/u/9905647?v=4', 'gravatar_id' => '', 'url' => 'https://api.github.com/users/Steinitch', 'html_url' => 'https://github.com/Steinitch', 'followers_url' => 'https://api.github.com/users/Steinitch/followers', 'following_url' => 'https://api.github.com/users/Steinitch/following{/other_user}', 'gists_url' => 'https://api.github.com/users/Steinitch/gists{/gist_id}', 'starred_url' => 'https://api.github.com/users/Steinitch/starred{/owner}{/repo}', 'subscriptions_url' => 'https://api.github.com/users/Steinitch/subscriptions', 'organizations_url' => 'https://api.github.com/users/Steinitch/orgs', 'repos_url' => 'https://api.github.com/users/Steinitch/repos', 'events_url' => 'https://api.github.com/users/Steinitch/events{/privacy}', 'received_events_url' => 'https://api.github.com/users/Steinitch/received_events', 'type' => 'User', 'site_admin' => false, 'name' => 'Paul Stettnisch', 'company' => nil, 'blog' => '', 'location' => nil, 'email' => 'paulstettnisch@gmail.com', 'hireable' => nil, 'bio' => nil, 'public_repos' => 10, 'public_gists' => 0, 'followers' => 1, 'following' => 1, 'created_at' => '2014-11-22T21:54:12Z', 'updated_at' => '2018-05-12T04:21:01Z' }, 'all_emails' => [] } }
    OmniAuth.config.add_mock(:github, omniauth_hash)
  end

  def mock_response
    {
      total_count:        272_975,
      incomplete_results: false,
    items: [{ id:                291_137,
              name:              'oh-my-zsh',
              full_name:         'robbyrussell/oh-my-zsh',
              owner:             {
                login:               'robbyrussell',
                id:                  257,
                avatar_url:          'https://avatars2.githubusercontent.com/u/257?v=4',
                gravatar_id:         '',
                url:                 'https://api.github.com/users/robbyrussell',
                html_url:            'https://github.com/robbyrussell',
                followers_url:       'https://api.github.com/users/robbyrussell/followers',
                following_url:       'https://api.github.com/users/robbyrussell/following{/other_user}',
                gists_url:           'https://api.github.com/users/robbyrussell/gists{/gist_id}',
                starred_url:         'https://api.github.com/users/robbyrussell/starred{/owner}{/repo}',
                subscriptions_url:   'https://api.github.com/users/robbyrussell/subscriptions',
                organizations_url:   'https://api.github.com/users/robbyrussell/orgs',
                repos_url:           'https://api.github.com/users/robbyrussell/repos',
                events_url:          'https://api.github.com/users/robbyrussell/events{/privacy}',
                received_events_url: 'https://api.github.com/users/robbyrussell/received_events',
                type:                'User',
                site_admin:          false
              },
              private:           false,
              html_url:          'https://github.com/robbyrussell/oh-my-zsh',
              description:       'A delightful community-driven (with 1,000+ contributors) framework for managing your zsh configuration. Includes 200+ optional plugins (rails, git, OSX, hub, capistrano, brew, ant, php, python, etc), over 140 themes to spice up your morning, and an auto-update tool so that makes it easy to keep up with the latest updates from the community.',
              fork:              false,
              url:               'https://api.github.com/repos/robbyrussell/oh-my-zsh',
              forks_url:         'https://api.github.com/repos/robbyrussell/oh-my-zsh/forks',
              keys_url:          'https://api.github.com/repos/robbyrussell/oh-my-zsh/keys{/key_id}',
              collaborators_url: 'https://api.github.com/repos/robbyrussell/oh-my-zsh/collaborators{/collaborator}',
              teams_url:         'https://api.github.com/repos/robbyrussell/oh-my-zsh/teams',
              hooks_url:         'https://api.github.com/repos/robbyrussell/oh-my-zsh/hooks',
              issue_events_url:  'https://api.github.com/repos/robbyrussell/oh-my-zsh/issues/events{/number}',
              events_url:        'https://api.github.com/repos/robbyrussell/oh-my-zsh/events',
              assignees_url:     'https://api.github.com/repos/robbyrussell/oh-my-zsh/assignees{/user}',
              branches_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/branches{/branch}',
              tags_url:          'https://api.github.com/repos/robbyrussell/oh-my-zsh/tags',
              blobs_url:         'https://api.github.com/repos/robbyrussell/oh-my-zsh/git/blobs{/sha}',
              git_tags_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/git/tags{/sha}',
              git_refs_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/git/refs{/sha}',
              trees_url:         'https://api.github.com/repos/robbyrussell/oh-my-zsh/git/trees{/sha}',
              statuses_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/statuses/{sha}',
              languages_url:     'https://api.github.com/repos/robbyrussell/oh-my-zsh/languages',
              stargazers_url:    'https://api.github.com/repos/robbyrussell/oh-my-zsh/stargazers',
              contributors_url:  'https://api.github.com/repos/robbyrussell/oh-my-zsh/contributors',
              subscribers_url:   'https://api.github.com/repos/robbyrussell/oh-my-zsh/subscribers',
              subscription_url:  'https://api.github.com/repos/robbyrussell/oh-my-zsh/subscription',
              commits_url:       'https://api.github.com/repos/robbyrussell/oh-my-zsh/commits{/sha}',
              git_commits_url:   'https://api.github.com/repos/robbyrussell/oh-my-zsh/git/commits{/sha}',
              comments_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/comments{/number}',
              issue_comment_url: 'https://api.github.com/repos/robbyrussell/oh-my-zsh/issues/comments{/number}',
              contents_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/contents/{+path}',
              compare_url:       'https://api.github.com/repos/robbyrussell/oh-my-zsh/compare/{base}...{head}',
              merges_url:        'https://api.github.com/repos/robbyrussell/oh-my-zsh/merges',
              archive_url:       'https://api.github.com/repos/robbyrussell/oh-my-zsh/{archive_format}{/ref}',
              downloads_url:     'https://api.github.com/repos/robbyrussell/oh-my-zsh/downloads',
              issues_url:        'https://api.github.com/repos/robbyrussell/oh-my-zsh/issues{/number}',
              pulls_url:         'https://api.github.com/repos/robbyrussell/oh-my-zsh/pulls{/number}',
              milestones_url:    'https://api.github.com/repos/robbyrussell/oh-my-zsh/milestones{/number}',
              notifications_url: 'https://api.github.com/repos/robbyrussell/oh-my-zsh/notifications{?since,all,participating}',
              labels_url:        'https://api.github.com/repos/robbyrussell/oh-my-zsh/labels{/name}',
              releases_url:      'https://api.github.com/repos/robbyrussell/oh-my-zsh/releases{/id}',
              deployments_url:   'https://api.github.com/repos/robbyrussell/oh-my-zsh/deployments',
              created_at:        '2009-08-28T18:15:37Z',
              updated_at:        '2018-05-13T00:54:46Z',
              pushed_at:         '2018-05-12T23:57:43Z',
              git_url:           'git://github.com/robbyrussell/oh-my-zsh.git',
              ssh_url:           'git@github.com:robbyrussell/oh-my-zsh.git',
              clone_url:         'https://github.com/robbyrussell/oh-my-zsh.git',
              svn_url:           'https://github.com/robbyrussell/oh-my-zsh',
              homepage:          'http://ohmyz.sh/',
              size:              4485,
              stargazers_count:  70_216,
              watchers_count:    70_216,
              language:          'Shell',
              has_issues:        true,
              has_projects:      true,
              has_downloads:     true,
              has_wiki:          true,
              has_pages:         false,
              forks_count:       14_608,
              mirror_url:        nil,
              archived:          false,
              open_issues_count: 1338,
              license:           {
                key:     'other',
                name:    'Other',
                spdx_id: nil,
                url:     nil
              },
              forks:             14_608,
              open_issues:       1338,
              watchers:          70_216,
              default_branch:    'master',
              score:             6.8794923
            }]
    }
  end


end
