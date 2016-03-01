{% if grains['os_family']=="Debian"  %}
  {% if pillar['vhost']['site']['state'] == 'enabled' %}
    {% set a2modid = "a2ensite " ~ pillar['vhost']['site']['name'] ~ apache.confext %}
  {% else %}
    {% set a2modid = "a2dissite " ~ pillar['apache']['site']['name'] ~ apache.confext %}
  {% endif %}

  {{ a2modid }}:
    cmd.run:
      {% if pillar['apache']['site']['state'] == 'enabled' %}
        - unless: test -f /etc/apache2/sites-enabled/{{ pillar['apache']['site']['name'] }}{{ apache.confext }}
      {% else %}
        - onlyif: test -f /etc/apache2/sites-enabled/{{ pillar['apache']['site']['name'] }}{{ apache.confext }}
        - order: 230
        - require:
          - pkg: apache
          - file: /etc/apache2/sites-available/{{ pillar['apache']['site']['name'] }}{{ apache.confext }}
{% endif %}