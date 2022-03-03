# unmineable-workers

Display workers on [unmineable](https://www.unmineable.com) account.

## Why?

To build watchdog and notifications on top of it.

## Setup

```bash
git clone git@github.com/pr0d1r2/unmineable-workers
cd unmineable-workers
bundle install
```

## Configuration

You need to obtain account identifier symilar to `aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee`.
Go to your account in [unmineable](https://www.unmineable.com) with web
browser and using inspect acquire it from requests.

```bash
echo aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee >> .account
```

## Usage

You can check all algo hosts:

```bash
bundle exec bin/all
```

List offline hosts vs expected list:

```bash
bundle exec bin/all_offline expected_host1 expected_host2
```

Also, you can list explicit algo hosts:

```bash
bundle exec bin/algo ethash
bundle exec bin/algo etchash
bundle exec bin/algo randomx
bundle exec bin/algo kawpow
```

List offline hosts vs expected list:

```bash
bundle exec bin/algo_offline ethash expected_host1 expected_host2
bundle exec bin/algo_offline etchash expected_host1 expected_host2
bundle exec bin/algo_offline randomx expected_host1 expected_host2
bundle exec bin/algo_offline kawpow expected_host1 expected_host2
```

## Development

```bash
bundle exec guard
```

## Related

There is also [unmineable-miner](https://github.com/pr0d1r2/unmineable-miner).

## Support

Consider using my [unmineable referral link](https://www.unmineable.com/?ref=3792-egij) (0.75% pool fee instead of 1% for you as well) or [donate](https://github.com/pr0d1r2/donate) or both.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
