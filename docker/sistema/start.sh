#!/bin/sh

rm /etc/apache2/sites-enabled/000-default.conf

#chequeamos si existe una instalacion, si no existe se baja la version seleccionada en .env y se realiza la instalacion
if [ ! -d "${WORKDIR}/instalacion" ];
then
        git clone https://github.com/SIU-Toba/framework.git ${WORKDIR} --branch ${TOBA_BRANCH}

        chown -R www-data:www-data ${WORKDIR}

        cd ${WORKDIR}

        if ${AGREGAR_BOOTSTRAP};
        then
                sed '/post-install-cmd/a\
                "yarn add font-awesome@4.7.0 respond.js@1.4.2 html5shiv@3.7.3  --modules-folder tmp_assets/",\
                \"yarn add bootstrap@3.3.7  --no-dev --modules-folder tmp_assets/",'  composer.json > /tmp/tmpfile ; mv /tmp/tmpfile composer.json
        fi

        sed 's/"description": "Framework de desarrollo web",/& \"version": "'${TOBA_BRANCH}'",/' ${WORKDIR}/composer.json > /tmp/composer ; mv /tmp/composer composer.json
        composer install

        echo -n ${TOBA_BASE_PASS} > /tmp/clave_pg;
        echo -n ${TOBA_PASS} > /tmp/clave_toba;

        ./bin/toba instalacion instalar \
                -d ${TOBA_ID_DESARROLLADOR} \
                -t ${TOBA_ES_PRODUCCION} \
                -h ${TOBA_BASE_HOST} \
                -p 5432 \
                -u ${TOBA_BASE_USER} \
                -b ${TOBA_BASE_NOMBRE} \
                -c /tmp/clave_pg \
                -k /tmp/clave_toba \
                -n ${TOBA_NOMBRE_INSTALACION} \
                --no-interactive \
                --usuario-admin ${TOBA_USUARIO_ADMIN}

        chmod -R 777 ${WORKDIR}
fi

ln -s ${WORKDIR}/instalacion/toba.conf /etc/apache2/sites-enabled/toba.conf

# opcional (ver .env), instala el plugin syntax highlighting para zsh
if ${ZSH_SYNTAX_HIGHLIGHTING} && [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ];
then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        echo "source ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc
fi

# opcional (ver .env), instala el plugin autosuggestions para zsh
if ${ZSH_AUTOSUGGESTIONS} && [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ];
then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        sed 's/plugins=(git/& zsh-autosuggestions/' $HOME/.zshrc > /tmp/tmpautosuggest ; mv /tmp/tmpautosuggest $HOME/.zshrc
fi

chmod +x /data/local/config/config.sh
cd /data/local/config
./config.sh

a2enmod rewrite
/usr/sbin/apachectl -DFOREGROUND