Vim�UnDo� "{%�{p�A6�&L������T�Ԕ�Q]Vo�    D                                   UW��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             UW��     �                 if (Meteor.isClient) {     // counter starts at 0   #  Session.setDefault('counter', 0);         Template.hello.helpers({       counter: function () {   $      return Session.get('counter');       }     });         Template.hello.events({   !    'click button': function () {   5      // increment the counter when button is clicked   9      Session.set('counter', Session.get('counter') + 1);       }     });   }       if (Meteor.isServer) {     Meteor.startup(function () {   '    // code to run on server at startup     });   }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             UW��     �                   5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             UW��    �   C   E          �                                                        //                                                                                                                                                                                     }�   B   D          :                                                        //�   A   C          �                                                        //                                                                                                                                                                                     });�   @   B          �                                                        //                                                                                                                                                                                 } �   ?   A          �                                                        //                                                                                                                                                                         });�   >   @          �                                                        //                                                                                                                                                             });�   =   ?          �                                                        //                                                                                                                                             score: Math.floor(Random.fraction() * 10) * 5�   <   >          �                                                        //                                                                                                                         name: name,�   ;   =          �                                                        //                                                                                                     Players.insert({�   :   <          �                                                        //                                                                                     _.each(names, function(name) {�   9   ;          �                                                        //                                                                         var names = ['Ada Lovelace', 'Grace Hopper', 'Marie Curie', 'Carl Friedrich Gauss'];�   8   :          �                                                        //                                                             if (Players.find().count() === 0) {�   7   9          :                                                        //�   6   8          �                                                        //                                                     Meteor.startup(function() {�   5   7          :                                                        //�   4   6          �                                                        //                                                 if (Meteor.isServer) {�   3   5          :                                                        //�   2   4          l                                                        //                                                 }�   1   3          n                                                        //                                                 });�   0   2          h                                                        //                                             }�   /   1          :                                                        //�   .   0          l                                                        //                                     return false;�   -   /          :                                                        //�   ,   .          q                                                        //                         event.target.score.value = '';�   +   -          d                                                        //             event.target.name.value = '';�   *   ,          E                                                        // Clear form�   (   *          c                                                                                                });�   '   )          w                                                                                score: Number(event.target.score.value)�   &   (          ^                                                                name: event.target.name.value,�   %   '          <                                            Players.insert({�   #   %          @                            'submit .addForm': function(event) {�   "   $          )                Template.addForm.events({�       "                                      });�      !          1                                                }�                 S                                        Players.remove($(event.target).data('id'));�                :                        'click .remove': function(event) {�                "            Template.list.events({�                2                                                };�                G                                                                    });�                d                                                            dataSource.data(Players.find().fetch());�                E                                            this.autorun(function() {�                C                                                                });�                J                                                    dataSource: dataSource�                A                                    this.$('#pager').kendoPager({�                G                                                                    });�                �                                                        template: '<tr><td>#:score#</td><td>#:name#</td><td><button class="remove" data-id="#:_id#">X</button></td></tr>'�                C                                            dataSource: dataSource,�                ;                            this.$('#list').kendoListView({�                ?                                                            });�                ;                                                pageSize: 4�   
             Z                                                                                        },�   	             S                                                                        dir: 'desc'�      
          G                                                        field: 'score',�      	          +                                    sort: {�                @                    var dataSource = new kendo.data.DataSource({�                -        Template.list.rendered = function() {5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             UW��     �              D   KPlayers = new Mongo.Collection('players'); //runs on both client and server       if (Meteor.isClient) {       )    Template.list.rendered = function() {       4        var dataSource = new kendo.data.DataSource({               sort: {                   field: 'score',                   dir: 'desc'               },               pageSize: 4           });       '        this.$('#list').kendoListView({   #            dataSource: dataSource,   }            template: '<tr><td>#:score#</td><td>#:name#</td><td><button class="remove" data-id="#:_id#">X</button></td></tr>'           });       %        this.$('#pager').kendoPager({   "            dataSource: dataSource           });       !        this.autorun(function() {   4            dataSource.data(Players.find().fetch());           });       };           Template.list.events({   *        'click .remove': function(event) {   7            Players.remove($(event.target).data('id'));   	        }       });           Template.addForm.events({   ,        'submit .addForm': function(event) {                   Players.insert({   .                name: event.target.name.value,   7                score: Number(event.target.score.value)               });                   // Clear form   8            //             event.target.name.value = '';   E            //                         event.target.score.value = '';               //   @            //                                     return false;               //   <            //                                             }   B            //                                                 });   @            //                                                 }               //   U            //                                                 if (Meteor.isServer) {               //   ^            //                                                     Meteor.startup(function() {               //   n            //                                                             if (Players.find().count() === 0) {   �            //                                                                         var names = ['Ada Lovelace', 'Grace Hopper', 'Marie Curie', 'Carl Friedrich Gauss'];   �            //                                                                                     _.each(names, function(name) {   �            //                                                                                                     Players.insert({   �            //                                                                                                                         name: name,   �            //                                                                                                                                             score: Math.floor(Random.fraction() * 10) * 5   �            //                                                                                                                                                             });   �            //                                                                                                                                                                         });   �            //                                                                                                                                                                                 }    �            //                                                                                                                                                                                     });               //   �            //                                                                                                                                                                                     }5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             UW��    �                   5��