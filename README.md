# zoo_workstation

## Supported Platforms

- Fedora 26

## Usage

### As-is

This cookbook should remain usable *without* a Chef Server, and without a [wrapper cookbook](https://blog.chef.io/2017/02/14/writing-wrapper-cookbooks/). Full functionality (attribute overrides, etc) can be set up via either of these methods, however, by default this cookbook should remain usable on leveraging Chef Solo or a tool such as [Chake](https://github.com/terceiro/chake).

```
sudo git clone --depth=1 https://github.com/dgoerger/chake_skel.git /var/chake
sudo git clone --depth=1 https://github.com/dgoerger/zoo_workstation.git /var/chake/cookbooks/zoo_workstation
echo -e "local://$(hostname):\n  run_list:\n      - recipe[zoo_workstation]" | sudo tee /var/chake/nodes.yaml
cd /var/chake; sudo rake converge
```
